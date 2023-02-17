# msvsdpim
## week1
| S. No.    | Week|Day|Action Item|Status|
|----------|-----|--------|-------|-----------------------|
|1.|0|1|Install Oracle virtual box with Ubuntu 20.04|:white_check_mark:|
|2.||2|Install Magic, ngspice and SKY130 PDKs|:white_check_mark:|
|3.||2|Install ALIGN tool|:white_check_mark:|
|4.||3|Create inverter and perform pre-layout using xschem or ngspice|:white_check_mark:|
|5.||3|Inverter Post-layout characterization using 2)|:white_check_mark:|
|6.||4|Inverter post-layout characterization using 3) |:white_check_mark:|
|7.||4|Compare the results obtained in 5) and 6) |:white_check_mark:|
|8.||5|Enroll in FREE VSD-custom layout course |:white_check_mark:|
|9.||6|Create the design shown in section 7 of the course and perform pre-layout using xschem or ngspice||
|10.||6|Post layout characterization using 2) and 3)||
|11.||6|Update your findings on your GitHub repo with the title “Week 0”|:white_check_mark:|
### Getting the tools
Note: open_pdk has to be installed last so it can correctly associate the xschem and magic directories. Note: if the configure step fails during any process, its most likely due to missing additional packages, and they need to be installed (preferably from source) to complete the installation
![image](https://user-images.githubusercontent.com/50217106/218158061-a319ea61-f115-48f8-8694-172a138004ba.png)


## Magic 
- Install steps
```
$  git clone git://opencircuitdesign.com/magic
$  cd magic
$	 ./configure
$  make
$  sudo make install
```
More info can be found at http://opencircuitdesign.com/magic/index.html
## Ngspice 
ngspice is the open-source spice simulator for electric and electronic circuits.
- Install steps
After downloading the tarball from https://sourceforge.net/projects/ngspice/files/ to a local directory, unpack it using:
```
 $ tar -zxvf ngspice-37.tar.gz
 $ cd ngspice-37
 $ mkdir release
 $ cd release
 $ ../configure  --with-x --with-readline=yes --disable-debug
 $ make
 $ sudo make install
 ```
## xschem
Xschem is a schematic capture program
- Install steps
```
$  git clone https://github.com/StefanSchippers/xschem.git xschem_git
$	./configure
$  make
$  sudo make install
```
More info can be found at http://repo.hu/projects/xschem/index.html

## open_pdks
Open_PDKs is distributed with files that support the Google/SkyWater sky130 open process description https://github.com/google/skywater-pdk. Open_PDKs will set up an environment for using the SkyWater sky130 process with open-source EDA tools and tool flows such as magic, qflow, openlane, netgen, klayout, etc.
- Install steps
```
$  git clone git://opencircuitdesign.com/open_pdks
$  open_pdks
$	./configure --enable-sky130-pdk
$  make
$  sudo make install
```
## Align - 
#### Analog Layout Intelligently generated from netlists
About :
#### ALIGN is an open source automatic layout generator for analog circuits jointly developed under the DARPA IDEA program by the University of Minnesota, Texas A&M University, and Intel Corporation.

![image](https://user-images.githubusercontent.com/50217106/218092464-0208dbd9-ac05-4b9a-9f00-ee752b3f90d3.png)


- The goal of ALIGN (Analog Layout, Intelligently Generated from Netlists) is to automatically translate an unannotated (or partially annotated) SPICE netlist of an analog circuit to a GDSII layout. The repository also releases a set of analog circuit designs.

The ALIGN flow includes the following steps:

Circuit annotation creates a multilevel hierarchical representation of the input netlist. This representation is used to implement the circuit layout in using a hierarchical manner. Design rule abstraction creates a compact JSON-format represetation of the design rules in a PDK. This repository provides a mock PDK based on a FinFET technology (where the parameters are based on published data). These design rules are used to guide the layout and ensure DRC-correctness. Primitive cell generation works with primitives, i.e., blocks at the lowest level of design hierarchy, and generates their layouts. Primitives typically contain a small number of transistor structures (each of which may be implemented using multiple fins and/or fingers). A parameterized instance of a primitive is automatically translated to a GDSII layout in this step. Placement and routing performs block assembly of the hierarchical blocks in the netlist and routes connections between these blocks, while obeying a set of analog layout constraints. At the end of this step, the translation of the input SPICE netlist to a GDSII layout is complete.

### Installing Align:
### 
### Prerequisites:
- gcc >= 6.1.0( for C++14 support) 
- Python >= 3.7 


Using the following command to install the Align tool:

```
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
git clone https://github.com/ALIGN-analoglayout/ALIGN-public
cd ALIGN-public

#Create a Python virtualenv
python -m venv general
source general/bin/activate
python -m pip install pip --upgrade

### Install ALIGN as a USER
pip install -v .

### Install ALIGN as a DEVELOPER
pip install -e .

pip install setuptools wheel pybind11 scikit-build cmake ninja
pip install -v -e .[test] --no-build-isolation
pip install -v --no-build-isolation -e . --no-deps --install-option='-DBUILD_TESTING=ON'
```
Testing Align tool -
- Non- SKy130 Example:
``` python 
schematic2layout.py ../ALIGN-pdk-sky130/examples/five_transistor_ota -p ../pdks/SKY130_PDK/
```
Install Klayout to view generated GDS files from ALIGN - sudo apt-get install klayout


### create a lab directory to perform experiments
``` bash
$ mkdir Lab1_and
$ cd Lab1_and
$ mkdir mag
$ mkdir netgen
$ mkdir xschem
$ cd xschem
$ cp /usr/local/share/pdk/sky130A/libs.tech/xschem/xschemrc .
$ cp /usr/local/share/pdk/sky130A/libs.tech/ngspice/spinit .spiceinit
$ cd ../mag
$ cp /usr/local/share/pdk/sky130A/libs.tech/magic/sky130A.magicrc .magicrc
$ cd ../netgen
$ cp /usr/local/share/pdk/sky130A/libs.tech/netgen//sky130A_setup.tcl .
```


### Inverter pre-layout experiments


### Creating inverter schematic using xschem

![Screenshot from 2023-02-10 09-42-33](https://user-images.githubusercontent.com/50217106/218092046-625e8fe8-2af5-40c4-b838-cd323d1fce08.png)



### Convert the schematic to a symbol
![Screenshot from 2023-02-10 09-42-36](https://user-images.githubusercontent.com/50217106/218091695-e57995fd-f585-492d-96ef-d046b3b4aed6.png)



### Using the symbol, an independent testbench is created to simulate the circuit

![Screenshot from 2023-02-11 03-21-54](https://user-images.githubusercontent.com/50217106/218207218-74cf8aa2-134b-4e47-a2ea-a150cb2427c6.png)

### Inverter DC analysis
![Screenshot from 2023-02-09 14-25-28](https://user-images.githubusercontent.com/50217106/218139861-b6a31207-693a-44c2-92c8-487d8d567a62.png)
![Screenshot from 2023-02-09 14-25-22](https://user-images.githubusercontent.com/50217106/218139881-58da4097-beca-4045-a07e-d97ca350870f.png)



![Screenshot from 2023-02-09 14-25-11](https://user-images.githubusercontent.com/50217106/218139230-5c07698e-fdc8-4ec4-9fe6-370c84e85f2b.png)


### Simulating testbench Schematic
#### Input pulse properties
- rise time - 10ps
- fall time - 10ps
- on time - 1ns
- period - 2ns

![Screenshot from 2023-02-11 03-22-52](https://user-images.githubusercontent.com/50217106/218207329-f1e3e74a-8d37-4adf-94ca-9a8907d7fe86.png)


### Calculation of Pre-layout Inverter delay using ngspice and plots

![Screenshot from 2023-02-11 03-23-31](https://user-images.githubusercontent.com/50217106/218207516-e60f8a80-00b5-43db-b20d-4b24a2a28d62.png)

clicking on the Vin and Vout curves give coordinates on the ngspice terminal
![Screenshot from 2023-02-11 03-25-10](https://user-images.githubusercontent.com/50217106/218207532-97cc2d2b-e9c5-4976-b77f-05b18304206b.png)


the difference in corrdinates give the pre-layout inverer delay values
delay = 13.59ps

Multiple iterations of simulations is performed and an average delay value is finalised.

## Creation of Layout using inverter schematic in layout tool MAGIC
Create a working directory with sky130A.tech, .xschemrc and .sky130magicrc files or you can import these files to the MAGIC directory itself. Either way open the working directory and use the following command
```
'MAGIC -T sky130A.tech
```
This opens up the tkcon and layout windows.

In the Layout window import the spice netlist of your inverter(one which has pins and fets, and is the bottomost hierarchy of the inverter testbench)
The metal input and output pins are imported and the nfet and pfet is imported.

![Screenshot from 2023-02-10 18-53-02](https://user-images.githubusercontent.com/50217106/218151916-737d2d97-53e8-4296-b2db-5f9b57072e7d.png)

Now we hover over the pins/fets and press i and then press m at the location we want to place them

Now route the metal1 layer such that the layout is DRC free
![Screenshot from 2023-02-10 21-34-39](https://user-images.githubusercontent.com/50217106/218149482-81fb02bd-7be3-4285-8536-787aa9b295f9.png)
Now, go to File --> save and select autowrite. We're not done yet. Go to the command window and type the following:
```
extract do local
extract all
```
Extract do local is an instruction to perform all extractions to the local directory and extract all does the actual extraction. We want our extraction for lvs to be in the spice format, so run the following commands.
```
ext2spice lvs
ext2spice cthresh 0 rthresh 0
ext2spice
```
Now, we can close magic.

If we run an ls in this directory we should see our .ext files and .mag files for the 
circuit - inverter.mag inverter.ext
We can also see a .spice netlist. This inverter.spice netlist generated post layout contains the parasitics that were absent in pre-layout netlist.
![Screenshot from 2023-02-10 21-50-00](https://user-images.githubusercontent.com/50217106/218151584-66d05733-377c-4f2b-8a13-4b265daf8527.png)

Now we need to use our pre-layout spice witht he post-layout parasitics netlist and perform spice simulations.
- Step I
Paste the pre-layout netlist of inverter testbench into the magic generated inverter spice netlist
### Pre- Layout Inverter Testbench Spice Netlist
```
** sch_path: /home/rahul/Documents/inverter_hier/Inv_tran1.sch
**.subckt Inv_tran1 vin vout
*.ipin vin
*.opin vout
X27 vin vout VDD GND inverter
V1 vin GND pulse(0 1.8 0 10ps 10ps 1ns 2ns)
.save i(v1)
V2 VDD GND 1.8
.save i(v2)
**** begin user architecture code

** opencircuitdesign pdks install
.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt



.tran 10p 4n
.save all

**** end user architecture code
**.ends

* expanding   symbol:  /home/rahul/Documents/inverter_hier/inverter.sym # of pins=4
** sym_path: /home/rahul/Documents/inverter_hier/inverter.sym
** sch_path: /home/rahul/Documents/inverter_hier/inverter.sch
.subckt inverter A Y VP VN
*.ipin A
*.iopin VP
*.iopin VN
*.opin Y
XM44 Y A VN VN sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM45 Y A VP VP sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends

.GLOBAL GND
.GLOBAL VDD
.end
```
After selectively pasting this netlist into the inverter.spice generated(extracted) from Magic Tool, the inverter.spice netlist looks like this
```
* SPICE3 file created from inverter.ext - technology: sky130A
** sch_path: /home/rahul/Documents/inverter_hier/Inv_tran1.sch
**.subckt Inv_tran1 vin vout
*.ipin vin
*.opin vout
X27 vin vout VDD GND inverter
V1 vin GND pulse(0 1.8 0 10ps 10ps 1ns 2ns)
.save i(v1)
V2 VDD GND 1.8
.save i(v2)
**** begin user architecture code

** opencircuitdesign pdks install
.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt



.tran 10p 4n
.save all

**** end user architecture code
**.ends

* expanding   symbol:  /home/rahul/Documents/inverter_hier/inverter.sym # of pins=4
** sym_path: /home/rahul/Documents/inverter_hier/inverter.sym
** sch_path: /home/rahul/Documents/inverter_hier/inverter.sch
.subckt inverter A Y VP VN
*.ipin A
*.iopin VP
*.iopin VN
*.opin Y
XM44 Y A VN VN sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM45 Y A VP VP sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends

.GLOBAL GND
.GLOBAL VDD

.subckt inverter A Y VP VN
X0 Y A VP XM45/w_n211_n319# sky130_fd_pr__pfet_01v8 ad=2.9e+11p pd=2.58e+06u as=2.9e+11p ps=2.58e+06u w=1e+06u l=150000u
X1 Y A VN VSUBS sky130_fd_pr__nfet_01v8 ad=2.9e+11p pd=2.58e+06u as=2.9e+11p ps=2.58e+06u w=1e+06u l=150000u
C0 A XM45/w_n211_n319# 0.33fF
C1 VP XM45/w_n211_n319# 0.21fF
C2 VN A 0.33fF
C3 Y XM45/w_n211_n319# 0.14fF
C4 VN Y 0.28fF
C5 VP A 0.29fF
C6 A Y 0.10fF
C7 VP Y 0.24fF
C8 A VSUBS 0.73fF
C9 Y VSUBS 0.90fF
C10 VN VSUBS 0.98fF
C11 VP VSUBS 0.71fF
C12 XM45/w_n211_n319# VSUBS 1.11fF **FLOATING

.ends
```

Open inverter.spice with ngspice
```
ngspice inverter.spice
```
run the following commands
```
run
dsiplay   //list of plots available
plot vin vout
```
![Screenshot from 2023-02-11 02-41-26](https://user-images.githubusercontent.com/50217106/218198322-2406ea3b-777c-438f-8c06-14e508e0690a.png)
![Screenshot from 2023-02-11 02-43-00](https://user-images.githubusercontent.com/50217106/218198578-cf119d92-fa72-492f-9b75-9e59304cfd15.png)
![Screenshot from 2023-02-11 02-44-28](https://user-images.githubusercontent.com/50217106/218198721-556bf6db-e22e-4d87-b981-3ce90f94e27d.png)
![Screenshot from 2023-02-11 02-45-06](https://user-images.githubusercontent.com/50217106/218198842-247798c8-a548-4270-a7b7-42fa1041cad5.png)

the plot vout vs vin is generated as below :

![Screenshot from 2023-02-11 02-27-20](https://user-images.githubusercontent.com/50217106/218204749-dfb0d8ea-7806-4ff6-aea3-2efd8a8f0ac5.png)

![Screenshot from 2023-02-11 02-28-50](https://user-images.githubusercontent.com/50217106/218204974-f1c5f258-e36e-4ab7-87ab-936886b5bac1.png)


We right click and stretch on the plots vin and vout. A new expkanded vin vs vout is generated. We expand until the vin and vout pulses are far apart. 
When we expand at the 50% rise points(approximately selected), and click on the two plots, the x coordinate(time) and y coordinate(voltage) appears on ngspice. If we subtract them we get the required delay(post-layout).

Post Layout Delay 1.02765-1.01551 = 0.01241( 12.5ps)

### Comparison of pre-LAYOUT  and post-LAYOUT

Input pulse specification in both 
- Rise Time- 10ps
- Fall Time- 10ps
- On time- 1ns
- Period- 2ns

- Pre-Layout Delay Vout-Vin - 13.59ps
- Post-Layout Delay Vout-Vin - 12.4ps


# week2


With discussions it was found that the post-layout simulation of inverter is incorrect the command ngspice inverter.spice gives the WARNING
```
WARNING - redefinition of .subckt ignored 
```
![Screenshot from 2023-02-11 02-41-26](https://user-images.githubusercontent.com/50217106/219765428-3f8e6139-ae88-4d1c-9258-44513b91f168.png)

which means that the spice netlist is incorrect in a way that tool finds multiple iterations of the same subcircuit and after investigating it was found that the subckt definition imported from pre-layout netlist had the same ports as the subckt definition created from magic.
After this correction and re-running ngspice in the inverter post-layout netlist, the following error pops up.
```
here is the generated error :* ngspice-37 : Circuit level simulation program
** The U. C. Berkeley CAD Group
** Copyright 1985-1994, Regents of the University of California.
** Copyright 2001-2022, The ngspice team.
** Please get your ngspice manual from http://ngspice.sourceforge.net/docs.html
** Please file your bug-reports at http://ngspice.sourceforge.net/bugrep.html
** Creation Date: Wed Feb  8 14:58:15 UTC 2023
******

Note: No compatibility mode selected!


Circuit: * ngspice file created from inverter.ext - technology: sky130a

ngspice 36 -> run
Doing analysis at TEMP = 27.000000 and TNOM = 27.000000

Warning: v1: no DC value, transient time 0 value used
Note: Starting dynamic gmin stepping
Trying gmin =   1.0000E-03 Note: One successful gmin step
Trying gmin =   1.0000E-04 Note: One successful gmin step
Trying gmin =   1.0000E-05 Note: One successful gmin step
Trying gmin =   1.0000E-06 Note: One successful gmin step
Trying gmin =   1.0000E-07 Note: One successful gmin step
Trying gmin =   1.0000E-08 Note: One successful gmin step
Trying gmin =   1.0000E-09 Note: One successful gmin step
Trying gmin =   1.0000E-10 Note: One successful gmin step
Trying gmin =   1.0000E-11 Note: One successful gmin step
Trying gmin =   1.0000E-12 Note: One successful gmin step
Trying gmin =   1.0000E-12 Note: One successful gmin step
Warning: Dynamic gmin stepping failed
Note: Starting true gmin stepping
Trying gmin =   1.0000E-03 Warning: Further gmin increment
Trying gmin =   5.6234E-03 Warning: Further gmin increment
Trying gmin =   8.6596E-03 Note: One successful gmin step
Trying gmin =   6.9783E-03 Note: One successful gmin step
Trying gmin =   5.0481E-03 Note: One successful gmin step
Trying gmin =   3.1059E-03 Warning: Further gmin increment
Trying gmin =   4.4709E-03 Warning: Further gmin increment
Trying gmin =   4.8971E-03 Note: One successful gmin step
Trying gmin =   4.6791E-03 Note: One successful gmin step
Trying gmin =   4.3702E-03 Warning: singular matrix:  check nodes x27.vsubs and x27.vsubs

Warning: Further gmin increment
Trying gmin =   4.5999E-03 Warning: Further gmin increment
Trying gmin =   4.6592E-03 Note: One successful gmin step
Trying gmin =   4.6295E-03 Warning: Further gmin increment
Trying gmin =   4.6518E-03 Note: One successful gmin step
Trying gmin =   4.6406E-03 Note: One successful gmin step
Trying gmin =   4.6239E-03 Warning: singular matrix:  check nodes x27.vsubs and x27.vsubs

Warning: Further gmin increment
Trying gmin =   4.6364E-03 Warning: Further gmin increment
Trying gmin =   4.6396E-03 Warning: Further gmin increment
Trying gmin =   4.6403E-03 Warning: singular matrix:  check nodes x27.vsubs and x27.vsubs

Warning: Further gmin increment
Trying gmin =   4.6405E-03 Warning: Last gmin step failed
Warning: True gmin stepping failed
Note: Starting source stepping
Supplies reduced to   0.0000% Note: One successful source step
Supplies reduced to   0.1000% Note: One successful source step
Supplies reduced to   0.2000% Note: One successful source step
Supplies reduced to   0.3500% Note: One successful source step
Supplies reduced to   0.5750% Note: One successful source step
Supplies reduced to   0.9125% Note: One successful source step
Supplies reduced to   1.4188% Note: One successful source step
Supplies reduced to   2.1781% Note: One successful source step
Supplies reduced to   3.3172% Note: One successful source step
Supplies reduced to   5.0258% Note: One successful source step
Supplies reduced to   7.5887% Note: One successful source step
Supplies reduced to  11.4330% Note: One successful source step
Supplies reduced to  17.1995% Supplies reduced to  11.4330% Note: One successful source step
Supplies reduced to  12.2980% Supplies reduced to  11.4330% Note: One successful source step
Supplies reduced to  11.5628% Note: One successful source step
Supplies reduced to  11.7574% Supplies reduced to  11.5628% Note: One successful source step
Supplies reduced to  11.5919% Note: One successful source step
Supplies reduced to  11.6357% Supplies reduced to  11.5919% Note: One successful source step
Supplies reduced to  11.5963% Note: One successful source step
Supplies reduced to  11.6029% Note: One successful source step
Supplies reduced to  11.6095% Supplies reduced to  11.6029% Note: One successful source step
Supplies reduced to  11.6036% Note: One successful source step
Supplies reduced to  11.6045% Supplies reduced to  11.6036% Note: One successful source step
Supplies reduced to  11.6036% Note: One successful source step
Supplies reduced to  11.6037% Warning: source stepping failed
Note: Transient op started
Note: Transient op finished successfully

Initial Transient Solution
--------------------------

Node                                   Voltage
----                                   -------
y                                     0.715671
a                                     -1.08398
vp                                     0.71602
x27.vsubs                            -0.739009
vn                                    -1.08398
v2#branch                         -9.42792e-08
v1#branch                          6.15798e-08

 Reference value :  0.00000e+00
No. of Data Rows : 129
```
We can see that ngspice tells us the algorithms it used to obtain a solution that converges for the given netlist. It first tried Dynamic gmin stepping algorithm, then true gmin stepping algorithm, then then source stepping algorithm all of which failed and the transient solution was created based on few source steppings that were successfull.
The following plot was generated.
![Screenshot from 2023-02-18 00-57-11](https://user-images.githubusercontent.com/50217106/219768375-968681cf-6804-493a-a726-b0aa4dca142a.png)
Clearly, input has been scaled and adjusted by the tool to get a solution.
When a circuit simulation is performed, the SPICE simulator iteratively solves the set of equations that describe the circuit to determine the voltages and currents at each node in the circuit. If the simulator is unable to find a solution that satisfies the equations, it is said to be "non-convergent". In other words, the simulation is not able to settle on a stable set of voltages and currents.
The warnings with "Further gmin increment" indicate that ngspice was unable to find a valid step size at the current gmin value and attempted to increment the value to find a valid one, but it still failed. The "singular matrix" warning indicates a possible issue with the circuit's topology, where the circuit matrix may have become singular, and there are one or more nodes that are indistinguishable from each other.

From the research it was assumed that the spice netlist is such that few nodes have become indistinguishable and upon investigation it was found that the GLOBAL definitions of VDD and VSS were missing.
After including the .GLOBAL definition our post-layout inverter natlist that has the parasitics looks like :
```
* NGSPICE file created from inverter.ext - technology: sky130A

.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.include /home/rahul/open_pdks/sky130/sky130A/libs.ref/sky130_fd_pr

X27 vin vout VDD GND inverter


V1 vin GND pulse(0 1.8 0 10ps 10ps 1ns 2ns)
.save i(v1)
V2 VDD GND 1.8
.save i(v2)


.tran 10p 4n
.save all



.subckt sky130_fd_pr__pfet_01v8_XGS3BL a_n73_n100# a_15_n100# w_n211_n319# a_n33_n197#
+ VSUBS
X0 a_15_n100# a_n33_n197# a_n73_n100# w_n211_n319# sky130_fd_pr__pfet_01v8 ad=2.9e+11p pd=2.58e+06u as=2.9e+11p ps=2.58e+06u w=1e+06u l=150000u
C0 a_15_n100# a_n73_n100# 0.16fF
C1 a_n33_n197# w_n211_n319# 0.26fF
C2 a_n73_n100# a_n33_n197# 0.03fF
C3 a_n73_n100# w_n211_n319# 0.09fF
C4 a_15_n100# a_n33_n197# 0.03fF
C5 a_15_n100# w_n211_n319# 0.06fF
C6 a_15_n100# VSUBS 0.02fF
C7 a_n73_n100# VSUBS 0.02fF
C8 a_n33_n197# VSUBS 0.05fF
C9 w_n211_n319# VSUBS 1.07fF
.ends

.subckt sky130_fd_pr__nfet_01v8_648S5X a_n73_n100# a_n33_n188# a_15_n100# a_n175_n274#
X0 a_15_n100# a_n33_n188# a_n73_n100# a_n175_n274# sky130_fd_pr__nfet_01v8 ad=2.9e+11p pd=2.58e+06u as=2.9e+11p ps=2.58e+06u w=1e+06u l=150000u
C0 a_n73_n100# a_n33_n188# 0.03fF
C1 a_15_n100# a_n73_n100# 0.16fF
C2 a_15_n100# a_n33_n188# 0.03fF
C3 a_15_n100# a_n175_n274# 0.08fF
C4 a_n73_n100# a_n175_n274# 0.11fF
C5 a_n33_n188# a_n175_n274# 0.30fF
.ends

.subckt inverter A Y VP VN
XXM45 VP Y XM45/w_n211_n319# A VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXM44 Y A VN VSUBS sky130_fd_pr__nfet_01v8_648S5X
C0 VP A 0.23fF
C1 Y VP 0.06fF
C2 Y A 0.04fF
C3 VN XM45/w_n211_n319# 0.00fF
C4 VP XM45/w_n211_n319# 0.16fF
C5 A XM45/w_n211_n319# 0.08fF
C6 A VN 0.27fF
C7 Y XM45/w_n211_n319# 0.12fF
C8 Y VN 0.07fF
C9 A VSUBS 0.62fF
C10 VN VSUBS 1.09fF
C11 Y VSUBS 0.63fF
C12 VP VSUBS 1.01fF
C13 XM45/w_n211_n319# VSUBS 1.11fF
.ends


.GLOBAL VDD
.GLOBAL GND

.end
```
Upon using ngspice upon this netlist, ngspice runs without any errors/warnings:

![Screenshot from 2023-02-16 03-42-23](https://user-images.githubusercontent.com/50217106/219775607-e19f1ca8-2353-4473-8734-f9e74c71c7b0.png)
![Screenshot from 2023-02-16 03-42-32](https://user-images.githubusercontent.com/50217106/219775685-339567f1-6602-4ab4-a77c-ef9421095ea0.png)
![Screenshot from 2023-02-16 03-42-16](https://user-images.githubusercontent.com/50217106/219775918-67914212-8e8e-469c-8fe1-4235e0399292.png)

The post-layout delay(calculated using methods shown above) then becomes:
1.03428-1.01504 = 0.01924 which is 19.24ps
The pre-layout delay was 13.59ps


### Function schematic - bottom hierarchy
![Screenshot from 2023-02-18 01-34-44](https://user-images.githubusercontent.com/50217106/219811151-70f447fc-4f8b-4f34-bb6f-c06a6bec64a5.png)

### Function Symbol
![Screenshot from 2023-02-18 01-34-30](https://user-images.githubusercontent.com/50217106/219811238-4506535c-c8de-474d-be57-b44ea425c9c2.png)

### Function Testbench

![Screenshot from 2023-02-18 01-33-48](https://user-images.githubusercontent.com/50217106/219811306-3ebd35e5-93c7-4b96-8b8f-ad82570bbed0.png)

On simulating the function using ngspice, the and plotting the output following curve is obtained - 

![Screenshot from 2023-02-17 00-13-28](https://user-images.githubusercontent.com/50217106/219810508-fc1eea69-2198-49e0-9b61-1cc15acdc98f.png)


### Import Function Spice netlist to magic

![Screenshot from 2023-02-17 00-15-04](https://user-images.githubusercontent.com/50217106/219808131-ba41c15d-4342-4012-bd9d-7da5814f3265.png)

### Arrange the fets to create a layout of the function

The layout is created using euler's path approach

![Screenshot from 2023-02-18 04-05-43](https://user-images.githubusercontent.com/50217106/219809328-daf9c566-dac1-4490-8a24-42461b025da9.png)


The layout is extracted and a spice netlist of the function is obtained which is edited with necessary changes to obtain the following plot when ngspice is used-


![Screenshot from 2023-02-17 23-31-21](https://user-images.githubusercontent.com/50217106/219809924-279cdb66-2437-4010-b41f-771e312c5e5f.png)

Clearly the pre and post layout does not matches.
Gmin stepping error is encountered again. This time all the errors in the spice netlist done on inverter post layout characterization were taken care of. Further investigation into the layout and netlist is required.



### Post Layout characterization of Inverter usign ALIGN tool
create a python virtual environment in the ALIGN public directory using following 
```
python -m venv general
source general/bin/activate
```
create a .sp file using "vim inverter.sp" and then use the pre-layout inverter spice netlist to get a file as shown below:
```
** sch_path: /home/rahul/Documents/inverter_hier/inverter.sch
.subckt inverter A Y VP VN
*.ipin A
*.iopin VP
*.iopin VN
*.opin Y
XM44 Y A VN VN sky130_fd_pr__nfet_01v8 L=150n W=1050n
XM45 Y A VP VP sky130_fd_pr__pfet_01v8 L=150n W=1050n
*.ends
.end


```
Bring this inverter.sp file to ALIGN-public/examples folder
Now move into work directory and use the following command to generate LEF and GDS of the inverter
```
schematic2layout.py ../ALIGN-pdk-sky130/examples/inverter -p ../ALIGN-pdk-sky130/SKY130_PDK/
```
ALIGN tool runs and the path to .gds is shown
![Screenshot from 2023-02-18 03-04-20](https://user-images.githubusercontent.com/50217106/219811036-a60d0078-f69c-446a-9370-b6cdd172ba73.png)

Navigate to /usr/bin. Here klayout tool resides 
Use the following command to view the LEF and GDS
klayout <generated path to gds>
klayout <generated path to lef>

#### INVERTER LEF view
![Screenshot from 2023-02-18 03-29-10](https://user-images.githubusercontent.com/50217106/219805442-18a68c44-5cd9-4299-b45f-b756eb5f059d.png)

#### Inverter GDS view

![Screenshot from 2023-02-18 03-18-04](https://user-images.githubusercontent.com/50217106/219805364-90f8241e-7f42-46e2-9cf6-b5e1d44f7110.png)

Now come to magic tool and open it using magic -T sky130A.tech
Import the inverter GDS using import GDS.
We get the following view :
![Screenshot from 2023-02-18 03-38-28](https://user-images.githubusercontent.com/50217106/219804875-9d62023c-0d3f-4606-9a4b-fa6925f0e026.png)
 
Label VDD and VSS
and extract the spice netlist using the following commands :
```
 extract do local 
 extract all
 ext2spice lvs
 ext2spice cthresh 0 rthresh 0
 extspice
 ```
 
 

