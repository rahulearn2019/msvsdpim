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
objDir = flowDir + "objects/" + args.platform + "/4bituc/"

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
    aux1 = "RINGOSC"
    aux2 = "onebitADC"
elif args.platform == "sky130hs":
    aux1 = "RINGOSC_hs"
    aux2 = "onebitADC_hs"


shutil.copyfile(
    srcDir + "RINGOSC.v", flowDir + "design/src/4bituc/RINGOSC.v"
)
shutil.copyfile(
    srcDir + "onebitADC.v", flowDir + "design/src/4bituc/onebitADC.v"
)
shutil.copyfile(
    srcDir + "async4bituc.v", flowDir + "design/src/4bituc/" + designName +
".v"
)


print("#----------------------------------------------------------------------")
print("# Verilog Generated")
print("#----------------------------------------------------------------------")
print()
if args.mode == "verilog":
    print("Exiting tool....")
    exit()

print("#----------------------------------------------------------------------")
print("# Run Synthesis and APR")
print("#----------------------------------------------------------------------")

p = sp.Popen(["make", "finish"], cwd=flowDir)
p.wait()
if p.returncode:
    print("[Error] Place and Route failed. Refer to the log file")
    exit(1)

print("#----------------------------------------------------------------------")
print("# Place and Route finished")
print("#----------------------------------------------------------------------")

p = sp.Popen(["make", "magic_drc"], cwd=flowDir)
p.wait()
if p.returncode:
    print("[Error] DRC failed. Refer to the report")
    exit(1)

print("#----------------------------------------------------------------------")
print("# DRC finished")
print("#----------------------------------------------------------------------")

p = sp.Popen(["make", "netgen_lvs"], cwd=flowDir)
p.wait()
if p.returncode:
    print("[Error] LVS failed. Refer to the report")
    exit(1)

print("#----------------------------------------------------------------------")
print("# LVS finished")
print("#----------------------------------------------------------------------")

if os.path.isdir(args.outputDir):
    # shutil.rmtree(genDir + args.outputDir)
    pass
if not args.outputDir.startswith("/"):
 #   os.mkdir(genDir + args.outputDir)
    outputDir = genDir + args.outputDir
else:
 #   os.mkdir(args.outputDir)
    outputDir = args.outputDir

print("genDir + args.outputDir: {}".format(genDir + args.outputDir))
print("flowDir: {}".format(flowDir))
print("args.platform: {}".format(args.platform))
print("designName: {}".format(designName))
subprocess.run(["ls", "-l", flowDir, "results/", args.platform, "/4bituc"])

shutil.copyfile(
    flowDir + "results/" + args.platform + "/4bituc/6_final.gds",
    outputDir + "/" + designName + ".gds",
)
shutil.copyfile(
    flowDir + "results/" + args.platform + "/4bituc/6_final.gds",
    outputDir + "/" + designName + ".def",
)
shutil.copyfile(
    flowDir + "results/" + args.platform + "/4bituc/6_final.v",
    outputDir + "/" + designName + ".v",
)
shutil.copyfile(
    flowDir + "results/" + args.platform + "/4bituc/6_1_fill.sdc",
    outputDir + "/" + designName + ".sdc",
)
shutil.copyfile(
    objDir + "netgen_lvs/spice/" + designName + ".spice",
   outputDir + "/" + designName + ".spice",
)
shutil.copyfile(
   objDir + "netgen_lvs/spice/" + designName + "_pex.spice",
   outputDir + "/" + designName + "_pex.spice",
)
shutil.copyfile(
    flowDir + "reports/" + args.platform + "/4bituc/6_final_drc.rpt",
    outputDir + "/6_final_drc.rpt",
)
shutil.copyfile(
    flowDir + "reports/" + args.platform + "/4bituc/6_final_lvs.rpt",
    outputDir + "/6_final_lvs.rpt",
)


print("#----------------------------------------------------------------------")
print("# Macro Generated")
print("#----------------------------------------------------------------------")
print()


print("#----------------------------------------------------------------------")
print("# Generating spice netlists for the macro")
print("#----------------------------------------------------------------------")



if args.mode == "full":
    print("#----------------------------------------------------------------------")
    print("# Simulation output Generated")
    print("#----------------------------------------------------------------------")


print("Exiting tool....")
exit()
