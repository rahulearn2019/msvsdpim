# RTL2GDS of the Analog design using openROAD( invoked by openFASOC)

With the necessary input files - gds of analog blocks and their dummy verilog we can proceed with the openFASOC flow to generate the complete analog block GDS.
A directory - avsd4bituc, is created in the generators directory of openfasoc
![Screenshot from 2023-03-21 21-58-23](https://user-images.githubusercontent.com/50217106/226677270-e1751ed4-8883-4d6b-a6fb-809adadde9a7.png)

The necessary sub-directories for avsd4bituc are created.

![Screenshot from 2023-03-21 03-45-24](https://user-images.githubusercontent.com/50217106/226679150-da9f3152-0875-4fb8-bbee-5d908d267302.png)

The dummy verilog files are placed in the src directory -

![Screenshot from 2023-03-21 22-23-07](https://user-images.githubusercontent.com/50217106/226683811-c87877b5-df45-4a49-9c7e-f7a1f04b1d3b.png)

- contents of the test.json file
![Screenshot from 2023-03-21 21-55-28](https://user-images.githubusercontent.com/50217106/226679622-c338be0f-15bc-4068-bf26-8f03b4304bc7.png)

modifications in toplevel makefile - edit the commands that will be used for different purposes - verilog generation, rtl2gds etc.
![Screenshot from 2023-03-21 03-45-33](https://user-images.githubusercontent.com/50217106/226678613-44fdf5ba-1ee5-41a2-8268-d09fc99f936d.png)

- contents of the tools directory 

![Screenshot from 2023-03-21 21-58-33](https://user-images.githubusercontent.com/50217106/226680028-e45414a2-0a3d-48de-8699-02d96ee274ef.png)

avsd4bituc-gen.py file is created and modifed as shown - name of the auxilliary cells in dummy verilog and name of the top level module is include
![Screenshot from 2023-03-21 20-17-21](https://user-images.githubusercontent.com/50217106/226677709-4fb05f65-b7c4-4a53-a69d-0b7e68b4f9c4.png)

Here's the complete avsd4bituc-gen.py script

```
#!/usr/bin/python3

import json
import os
import re
import shutil
import subprocess as sp
import sys
import time



from parameter import args, main, designName

genDir = os.path.join(os.path.dirname(os.path.relpath(__file__)), "../")
srcDir = genDir + "src/"
flowDir = genDir + "flow/"
designDir = genDir + "designs/src/4bituc/"
simDir = genDir + "simulations/"
commonDir = genDir + "../../common/"
platformDir = genDir + "../../common/platforms/" + args.platform + "/"
objDir = flowDir + "objects/" + args.platform + "/PLL/"

# ------------------------------------------------------------------------------
# Clean the workspace
# ------------------------------------------------------------------------------
print("#----------------------------------------------------------------------")
print("# Cleaning the workspace...")
print("#----------------------------------------------------------------------")
if args.clean:
    p = sp.Popen(["make", "clean_all"], cwd=genDir)
    p.wait()

p = sp.Popen(["git", "checkout", platformDir + "cdl/sky130_fd_sc_hd.spice"])
p.wait()

print("Loading platform_config file...")
print()
try:
    with open(genDir + "../../common/platform_config.json") as file:
        jsonConfig = json.load(file)
except ValueError as e:
    print("Error occurred opening or loading json file.")
    print >> sys.stderr, "Exception: %s" % str(e)
    sys.exit(1)

print("PDK_ROOT value: {}".format(os.getenv("PDK_ROOT")))

# TODO: GHA/GCP/Whatever check
pdk = None
if os.getenv("PDK_ROOT") is not None:
    pdk = os.path.join(os.environ["PDK_ROOT"], "sky130A")
else:
    open_pdks_key = "open_pdks"
    pdk = jsonConfig[open_pdks_key]

if not os.path.isdir(os.path.join(pdk, "libs.ref")):
    print("Cannot find libs.ref folder from open_pdks in " + pdk)
    sys.exit(1)
elif not os.path.isdir(os.path.join(pdk, "libs.tech")):
    print("Cannot find libs.tech folder from open_pdks in " + pdk)
    sys.exit(1)
else:
    sky130A_path = commonDir + "drc-lvs-check/sky130A/"
    if not os.path.isdir(sky130A_path):
        os.mkdir(sky130A_path)
    try:
        sp.Popen(
            [
                "sed -i 's/set PDKPATH \".*/set PDKPATH $env(PDK_ROOT)\/sky130A/' $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc"
            ],
            shell=True,
        ).wait()
    except:
        pass
    shutil.copy2(os.path.join(pdk, "libs.tech/magic/sky130A.magicrc"), sky130A_path)
    shutil.copy2(os.path.join(pdk, "libs.tech/netgen/sky130A_setup.tcl"), sky130A_path)


Fmin, Fmax, ninv = main()


print("Inv : ", ninv)
print("INV:{0}\n".format(ninv))

if args.ninv:
    print("target number of inverters: " + args.ninv)
    ninv = int(args.ninv)


print("#----------------------------------------------------------------------")
print("# Verilog Generation")
print("#----------------------------------------------------------------------")


if args.platform == "sky130hd":
    aux1 = "onebitADC"
    aux2 = "ringosc"
elif args.platform == "sky130hs":
    aux1 = "onebitADC_hs"
    aux2 = "ringosc_hs"

with open(srcDir + "/async4bituc.v", "r") as file:
    filedata = file.read()
if args.mode == "verilog":
    with open(flowDir+ "design/src/4bituc/async4bituc.v", "w") as file:
        file.write(filedata)

with open(srcDir + "/ringosc.v", "r") as file:
    filedata = file.read()
if args.mode == "verilog":
    with open(flowDir+ "design/src/4bituc/ringosc.v", "w") as file:
        file.write(filedata)

with open(srcDir + "/onebitADC.v", "r") as file:
    filedata = file.read()
if args.mode == "verilog":
    with open(flowDir+ "design/src/4bituc/onebitADC.v", "w") as file:
        file.write(filedata)

print("# AUC - Behavioural Verilog Generated")
print("#----------------------------------------------------------------------")
print("# Verilog Generated")
print("#----------------------------------------------------------------------")
print()
if args.mode == "verilog":
    print("Exiting tool....")
    exit()

print("#----------------------------------------------------------------------")
print("# Run Synthesis")
print("#----------------------------------------------------------------------")

p = sp.Popen(["make", "synth"], cwd=flowDir)
p.wait()
if p.returncode:
    print("[Error] Snthesis failed. Refer to the log file")
    exit(1)

print("#----------------------------------------------------------------------")
print("# Synthesis finished")
print("#----------------------------------------------------------------------")

print("#----------------------------------------------------------------------")
print("# Run Floorplan")
print("#----------------------------------------------------------------------")
p = sp.Popen(["make", "floorplan"], cwd=flowDir)
p.wait()
if p.returncode:
    print("[Error] Floorplan failed. Refer to the log file")
    exit(1)
print("#----------------------------------------------------------------------")
print("# Floorplan finished")
print("#----------------------------------------------------------------------")

print("#----------------------------------------------------------------------")
print("# Run Placement")
print("#----------------------------------------------------------------------")
p = sp.Popen(["make", "place"], cwd=flowDir)
p.wait()
if p.returncode:
    print("[Error] Placement failed. Refer to the log file")
    exit(1)
print("#----------------------------------------------------------------------")
print("# Placement finished")
print("#----------------------------------------------------------------------")

print("#----------------------------------------------------------------------")
print("# Run Routing")
print("#----------------------------------------------------------------------")
p = sp.Popen(["make", "finish"], cwd=flowDir)
p.wait()
if p.returncode:
    print("[Error] Place and route failed. Refer to the log file")
    exit(1)
print("#----------------------------------------------------------------------")
print("# Place and Route finished")

```

- The content of parse_rpt.py python script :

![Screenshot from 2023-03-21 21-59-19](https://user-images.githubusercontent.com/50217106/226681726-51d8dbea-79f6-4472-93da-71607ca46e40.png)


The LEF and GDS of the auxilliary cells are placed in avsd4bituc/blocks/sky130hd - lef and gds folders respectively

![Screenshot from 2023-03-21 20-01-36](https://user-images.githubusercontent.com/50217106/226682116-0272ff73-fda6-4d24-871f-5ce5811e9a77.png)

![Screenshot from 2023-03-21 20-01-19](https://user-images.githubusercontent.com/50217106/226682130-094d3d7a-bc7f-456b-b725-3fe2016b6bb8.png)
