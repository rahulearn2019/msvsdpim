### VSD RESEARCH PROGRAMME - MIXED SIGNAL PHYSICAL DESIGN
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

------------------------------------------------------

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
![Screenshot from 2023-02-23 00-18-57](https://user-images.githubusercontent.com/50217106/220984983-d0ab609f-b274-476d-993d-02789dfbf39c.png)
### Function Symbol
Symbol was created from the option - "create symbol for schematic" and then use that symbol in the testbench schematic

### Function Testbench
![Screenshot from 2023-02-23 00-18-54](https://user-images.githubusercontent.com/50217106/220985156-86ab6713-f1a2-48d0-8b5e-47dcef141f0e.png)
### Function Spice netlist
```
** sch_path: /home/rahul/Documents/function/function_top.sch
.subckt function_top A B Y D C F E
*.PININFO A:I B:I Y:O D:I C:I F:I E:I
X27 VDD A B D C F E Y GND function_skeleton
V1 VDD GND 1.8
.save i(v1)
VA A GND pulse(0 1.8 0 10ps 10ps 1ns 2ns)
.save i(va)
VB B GND pulse(0 1.8 0.1ns 10ps 10ps 1ns 2ns)
.save i(vb)
VC C GND pulse(0 1.8 0.2ns 10ps 10ps 1ns 2ns)
.save i(vc)
VF F GND pulse(0 1.8 0.5ns 10ps 10ps 1ns 2ns)
.save i(vf)
VD D GND pulse(0 1.8 0.3ns 10ps 10ps 1ns 2ns)
.save i(vd)
VE E GND pulse(0 1.8 0.4ns 10ps 10ps 1ns 2ns)
.save i(ve)
**** begin user architecture code

** opencircuitdesign pdks install
.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt



.tran 0.01n 10n
.save all

**** end user architecture code
.ends

* expanding   symbol:  /home/rahul/Documents/function/function_skeleton.sym # of pins=9
** sym_path: /home/rahul/Documents/function/function_skeleton.sym
** sch_path: /home/rahul/Documents/function/function_skeleton.sch
.subckt function_skeleton VP A B D C F E Y VN
*.PININFO A:I B:I C:I D:I E:I F:I VP:B VN:B Y:O
XM44 Y E net2 net2 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM45 net2 F VN VN sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM46 Y A net1 net1 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM47 net3 D net5 net5 sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM48 Y C net1 net1 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM49 net1 B VN VN sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM50 net1 D VN VN sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM51 net3 C net4 net4 sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM52 net4 A VP VP sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM53 net5 B VP VP sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM54 Y E net3 net3 sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM55 Y F net3 net3 sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
.ends

.GLOBAL GND
.GLOBAL VDD
.end
```
On simulating the function using ngspice and plotting the output following curve is obtained - 
![Screenshot from 2023-02-19 23-41-38](https://user-images.githubusercontent.com/50217106/220985619-5ecf2664-49dc-489c-aa88-608f697ca7ed.png)


### Import Function Spice netlist to magic

![Screenshot from 2023-02-17 00-15-04](https://user-images.githubusercontent.com/50217106/219808131-ba41c15d-4342-4012-bd9d-7da5814f3265.png)

### Arrange the fets to create a layout of the function

The layout is created using euler's path approach

![Screenshot from 2023-02-22 13-21-12](https://user-images.githubusercontent.com/50217106/220985932-82acd4bd-053f-4e8b-a84c-7ea8dd925da6.png)


The layout is extracted and a spice netlist of the function is obtained which is edited with necessary changes(pre-layout excitations and .lib definitions to obtain 
```
* NGSPICE file created from function_skeleton.ext - technology: sky130A

** opencircuitdesign pdks install
.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt


X27 VDD A B D C F E Y GND function_skeleton
V1 VDD GND 1.8
.save i(v1)
VA A GND pulse(0 1.8 0 10ps 10ps 1ns 2ns)
.save i(va)
VB B GND pulse(0 1.8 0.1ns 10ps 10ps 1ns 2ns)
.save i(vb)
VC C GND pulse(0 1.8 0.2ns 10ps 10ps 1ns 2ns)
.save i(vc)
VF F GND pulse(0 1.8 0.5ns 10ps 10ps 1ns 2ns)
.save i(vf)
VD D GND pulse(0 1.8 0.3ns 10ps 10ps 1ns 2ns)
.save i(vd)
VE E GND pulse(0 1.8 0.4ns 10ps 10ps 1ns 2ns)
.save i(ve)
**** begin user architecture code


.tran 0.01n 10n
.save all

.subckt sky130_fd_pr__nfet_01v8_648S5X a_n73_n100# a_n33_n188# a_15_n100# a_n175_n274#
X0 a_15_n100# a_n33_n188# a_n73_n100# a_n175_n274# sky130_fd_pr__nfet_01v8 ad=0.29 pd=2.58 as=0.29 ps=2.58 w=1 l=0.15
C0 a_n33_n188# a_n73_n100# 0.03fF
C1 a_15_n100# a_n73_n100# 0.16fF
C2 a_15_n100# a_n33_n188# 0.03fF
C3 a_15_n100# a_n175_n274# 0.08fF
C4 a_n73_n100# a_n175_n274# 0.11fF
C5 a_n33_n188# a_n175_n274# 0.30fF
.ends

.subckt sky130_fd_pr__pfet_01v8_XGS3BL a_n73_n100# a_15_n100# w_n211_n319# a_n33_n197#
+ VSUBS
X0 a_15_n100# a_n33_n197# a_n73_n100# w_n211_n319# sky130_fd_pr__pfet_01v8 ad=0.29 pd=2.58 as=0.29 ps=2.58 w=1 l=0.15
C0 a_15_n100# a_n33_n197# 0.03fF
C1 a_15_n100# w_n211_n319# 0.06fF
C2 a_n73_n100# a_15_n100# 0.16fF
C3 w_n211_n319# a_n33_n197# 0.26fF
C4 a_n73_n100# a_n33_n197# 0.03fF
C5 a_n73_n100# w_n211_n319# 0.09fF
C6 a_15_n100# VSUBS 0.02fF
C7 a_n73_n100# VSUBS 0.02fF
C8 a_n33_n197# VSUBS 0.05fF
C9 w_n211_n319# VSUBS 1.07fF
.ends

.subckt function_skeleton VP A B D C F E Y VN
XXM45 m1_n176_706# E m1_840_708# VSUBS sky130_fd_pr__nfet_01v8_648S5X
XXM47 m1_n174_2024# Y w_n6_1802# E VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXM46 m1_n1862_706# A m1_n1194_708# VSUBS sky130_fd_pr__nfet_01v8_648S5X
XXM48 m1_840_708# F VN VSUBS sky130_fd_pr__nfet_01v8_648S5X
XXM49 VN D m1_n1194_708# VSUBS sky130_fd_pr__nfet_01v8_648S5X
XXM50 m1_n1194_708# B VN VSUBS sky130_fd_pr__nfet_01v8_648S5X
XXM51 m1_2824_2014# VP w_n6_1802# B VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXM52 m1_n174_2024# m1_2824_2014# w_n6_1802# D VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXM53 Y m1_n174_2024# w_n6_1802# F VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXM54 m1_n1188_2022# m1_n174_2024# w_n6_1802# C VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXM55 VP m1_n1188_2022# w_n6_1802# A VSUBS sky130_fd_pr__pfet_01v8_XGS3BL
XXM44 m1_n1194_708# C m1_n176_706# VSUBS sky130_fd_pr__nfet_01v8_648S5X
C0 m1_n1194_708# VN 1.03fF
C1 A m1_n1862_706# 0.01fF
C2 w_n6_1802# m1_n1194_708# 0.03fF
C3 m1_n176_706# m1_n1194_708# 0.10fF
C4 w_n6_1802# C 0.20fF
C5 m1_n176_706# C 0.04fF
C6 m1_840_708# E 0.01fF
C7 C VP 0.01fF
C8 C m1_n174_2024# 0.02fF
C9 Y m1_n1194_708# 0.24fF
C10 m1_n1188_2022# w_n6_1802# 0.41fF
C11 C Y 0.21fF
C12 m1_n1188_2022# VP 0.04fF
C13 m1_n1188_2022# m1_n174_2024# -0.00fF
C14 F m1_2824_2014# 0.00fF
C15 m1_n1188_2022# Y 0.01fF
C16 F VN 0.02fF
C17 w_n6_1802# F 0.28fF
C18 D m1_2824_2014# 0.02fF
C19 m1_n176_706# F 0.00fF
C20 D VN 0.02fF
C21 D w_n6_1802# 0.26fF
C22 C m1_n1194_708# 0.02fF
C23 F VP 0.01fF
C24 F m1_n174_2024# 0.03fF
C25 D VP 0.01fF
C26 F Y 0.11fF
C27 D m1_n174_2024# 0.02fF
C28 m1_n1188_2022# m1_n1194_708# 0.03fF
C29 D Y 0.00fF
C30 m1_n1188_2022# C 0.01fF
C31 B m1_2824_2014# 0.01fF
C32 F m1_n1194_708# 0.01fF
C33 w_n6_1802# m1_n1862_706# 0.00fF
C34 B VN 0.03fF
C35 B w_n6_1802# 0.16fF
C36 m1_n176_706# m1_n1862_706# 0.00fF
C37 D m1_n1194_708# 0.03fF
C38 E VN 0.00fF
C39 E w_n6_1802# 0.27fF
C40 m1_n1862_706# VP 0.02fF
C41 B VP 0.02fF
C42 E m1_n176_706# 0.03fF
C43 B m1_n174_2024# 0.00fF
C44 E VP 0.01fF
C45 w_n6_1802# A 0.10fF
C46 m1_n1862_706# Y 0.28fF
C47 E m1_n174_2024# 0.03fF
C48 m1_n176_706# A 0.00fF
C49 m1_840_708# VN 0.03fF
C50 m1_840_708# w_n6_1802# 0.02fF
C51 E Y 0.29fF
C52 m1_840_708# m1_n176_706# 0.00fF
C53 A VP 0.03fF
C54 A m1_n174_2024# 0.00fF
C55 A Y 0.24fF
C56 m1_n1862_706# m1_n1194_708# 0.00fF
C57 m1_840_708# Y 0.09fF
C58 B m1_n1194_708# 0.02fF
C59 D F 0.05fF
C60 E m1_n1194_708# 0.01fF
C61 E C 0.05fF
C62 A m1_n1194_708# 0.01fF
C63 m1_840_708# m1_n1194_708# 0.11fF
C64 C A 0.06fF
C65 m1_n1188_2022# E 0.00fF
C66 m1_840_708# C 0.00fF
C67 m1_n1188_2022# A 0.01fF
C68 E F 0.02fF
C69 B D 0.06fF
C70 w_n6_1802# m1_2824_2014# 0.53fF
C71 w_n6_1802# VN 0.01fF
C72 m1_2824_2014# VP 0.04fF
C73 m1_n176_706# VN 0.00fF
C74 w_n6_1802# m1_n176_706# 0.02fF
C75 m1_840_708# F 0.02fF
C76 m1_2824_2014# m1_n174_2024# -0.00fF
C77 VP VN 0.01fF
C78 w_n6_1802# VP 0.51fF
C79 m1_n174_2024# VN 0.03fF
C80 m1_2824_2014# Y 0.00fF
C81 w_n6_1802# m1_n174_2024# 1.46fF
C82 m1_n176_706# m1_n174_2024# 0.03fF
C83 w_n6_1802# Y 0.91fF
C84 m1_n174_2024# VP 0.26fF
C85 m1_n176_706# Y 0.26fF
C86 Y VP 0.05fF
C87 Y m1_n174_2024# 0.13fF
C88 m1_2824_2014# m1_n1194_708# 0.03fF
C89 B VSUBS 0.57fF
C90 D VSUBS 0.43fF
C91 F VSUBS 0.40fF
C92 E VSUBS 0.41fF
C93 C VSUBS 0.49fF
C94 A VSUBS 0.66fF
C95 w_n6_1802# VSUBS 11.23fF
C96 m1_n176_706# VSUBS 0.48fF
C97 m1_n1188_2022# VSUBS -0.25fF
C98 VP VSUBS 2.32fF
C99 m1_n174_2024# VSUBS 0.07fF
C100 m1_2824_2014# VSUBS -0.90fF
C101 VN VSUBS 2.27fF
C102 m1_n1194_708# VSUBS 1.08fF
C103 m1_n1862_706# VSUBS 0.36fF
C104 Y VSUBS -0.25fF
C105 m1_840_708# VSUBS 0.06fF
.ends


.GLOBAL VDD
.GLOBAL GND

.end

```
the following plot when ngspice is used-
![Screenshot from 2023-02-21 16-33-04](https://user-images.githubusercontent.com/50217106/220986291-d0aed3b7-8a71-463c-8ff4-740d3fc6aa53.png)

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
.subckt inverter A Y VP VN
XM44 Y A VN VN sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4 m=1
XM45 Y A VP VP sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=4 m=1
.ends inverter
```
Bring this inverter.sp file to ALIGN-public/examples folder
Now move into work directory and use the following command to generate LEF and GDS of the inverter
```
schematic2layout.py ../examples/inverter -p ../pdks/SKY130_PDK/
```
ALIGN tool runs and the path to .gds is shown
![Screenshot from 2023-02-18 03-04-20](https://user-images.githubusercontent.com/50217106/219811036-a60d0078-f69c-446a-9370-b6cdd172ba73.png)

Navigate to /usr/bin. Here klayout tool resides 
Use the following command to view the LEF and GDS
klayout <generated path to gds>
klayout <generated path to lef>

#### INVERTER LEF view

![Screenshot from 2023-02-23 23-36-44](https://user-images.githubusercontent.com/50217106/220992548-b6c46ab2-1bde-4547-be1f-30b8fb81c4e4.png)

#### Inverter GDS view
![Screenshot from 2023-02-23 23-36-33](https://user-images.githubusercontent.com/50217106/220992619-ea822a21-1373-45af-9426-1226819166fb.png)

Now come to magic tool and open it using magic -T sky130A.tech
Import the inverter GDS using import GDS.
We get the following view :
![Screenshot from 2023-02-23 23-35-25](https://user-images.githubusercontent.com/50217106/220992703-8e33d369-bf96-4930-8555-fc75321cdebe.png)

extract the spice netlist using the following commands :
```
 extract do local 
 extract all
 ext2spice cthresh 0 rthresh 0
 extspice
 ```
## Post Layout Spice of inverter
```
X0 Y A VN VN sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X1 VN A Y VN sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X2 Y A VN VN sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X3 VN A Y VN sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X4 INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# A Y INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X5 Y A INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X6 INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# A Y INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X7 Y A INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
C0 Y INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# 1.57fF
C1 Y A 0.69fF
C2 A INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# 1.65fF
C3 Y VN 1.33fF **FLOATING
C4 A VN 1.79fF **FLOATING
C5 INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# VN 3.60fF **FLOATING


```

## Modified spice of inverter by including .lib definition and pre-layout excitations
```
X27 vin vout VDD GND inverter
**.option scale=1e-9
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
X0 Y A VN VN sky130_fd_pr__nfet_01v8 w=1.05 l=0.15
X1 VN A Y VN sky130_fd_pr__nfet_01v8 w=1.05 l=0.15
X2 Y A VN VN sky130_fd_pr__nfet_01v8 w=1.05 l=0.15
X3 VN A Y VN sky130_fd_pr__nfet_01v8 w=1.05 l=0.15
X4 INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# A Y INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# sky130_fd_pr__pfet_01v8 w=1.05 l=0.15
X5 Y A INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# sky130_fd_pr__pfet_01v8 w=1.05 l=0.15
X6 INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# A Y INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# sky130_fd_pr__pfet_01v8 w=1.05 l=0.15
X7 Y A INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# sky130_fd_pr__pfet_01v8 w=1.05 l=0.15
C0 A INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# 1.65fF
C1 A Y 0.69fF
C2 Y INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# 1.57fF
C3 Y VN 1.33fF 
**FLOATING
C4 A VN 1.79fF 
**FLOATING
C5 INV_21710508_0_0_1677143133_0/PMOS_S_28785657_X2_Y1_1677143134_1677143133_0/w_0_0# VN 3.60fF 
**FLOATING
.ends

.GLOBAL VDD
.GLOBAL GND

.end

```
## Ngspice output of inverter


![Screenshot from 2023-02-23 14-50-25](https://user-images.githubusercontent.com/50217106/220990943-112c26ff-05b0-46b9-8d08-a1fe9b608ab0.png)

# Function using ALIGN flow
## .sp of function created form pre-layout spice of testbench
```
.subckt function_skeleton VP A B D C F E Y VN
*.PININFO A:I B:I C:I D:I E:I F:I VP:B VN:B Y:O
XM44 Y E net2 net2 sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2 m=1
XM45 net2 F VN VN sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2 m=1
XM46 Y A net1 net1 sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2 m=1
XM47 net3 D net5 net5 sky130_fd_pr__pfet_01v8 L=150n W=420n nf=2 m=1
XM48 Y C net1 net1 sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2 m=1
XM49 net1 B VN VN sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2 m=1
XM50 net1 D VN VN sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2 m=1
XM51 net3 C net4 net4 sky130_fd_pr__pfet_01v8 L=150n W=420n nf=2 m=1
XM52 net4 A VP VP sky130_fd_pr__pfet_01v8 L=150n W=420n nf=2 m=1
XM53 net5 B VP VP sky130_fd_pr__pfet_01v8 L=150n W=420n nf=2 m=1
XM54 Y E net3 net3 sky130_fd_pr__pfet_01v8 L=150n W=420n nf=2 m=1
XM55 Y F net3 net3 sky130_fd_pr__pfet_01v8 L=150n W=420n nf=2 m=1
.end
```
## Function GDS view using Klayout generated by ALIGN
![Screenshot from 2023-02-22 13-15-13](https://user-images.githubusercontent.com/50217106/220989295-d6f46d98-1429-4a35-ba98-95e024fde793.png)

## Function GDS when read in Magic
![Screenshot from 2023-02-22 16-22-35](https://user-images.githubusercontent.com/50217106/220989315-55838255-6551-4055-8969-7afa9e60cdb2.png)

## Extracted spice from magic
```

X0 m1_828_2996# C m1_828_2996# m1_828_2996# sky130_fd_pr__pfet_01v8 ad=0.0588 pd=0.7 as=0.1113 ps=1.37 w=0.42 l=0.15
X1 m1_828_2996# C m1_828_2996# m1_828_2996# sky130_fd_pr__pfet_01v8 ad=0.1113 pd=1.37 as=0.0588 ps=0.7 w=0.42 l=0.15
X2 m1_828_2996# D m1_828_2996# m1_828_2996# sky130_fd_pr__pfet_01v8 ad=1.3608 pd=16.56 as=0 ps=0 w=0.42 l=0.15
X3 m1_828_2996# D m1_828_2996# m1_828_2996# sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.42 l=0.15
X4 DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# li_1523_487# m1_828_2996# DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# sky130_fd_pr__pfet_01v8 ad=0.1113 pd=1.37 as=0.0588 ps=0.7 w=0.42 l=0.15
X5 m1_828_2996# A DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# sky130_fd_pr__pfet_01v8 ad=0.0588 pd=0.7 as=0.1113 ps=1.37 w=0.42 l=0.15
X6 DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# A m1_828_2996# DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# sky130_fd_pr__pfet_01v8 ad=0.0588 pd=0.7 as=0.0588 ps=0.7 w=0.42 l=0.15
X7 m1_828_2996# li_1523_487# DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# sky130_fd_pr__pfet_01v8 ad=0.0588 pd=0.7 as=0.0588 ps=0.7 w=0.42 l=0.15
X8 VSUBS D VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0.0588 pd=0.7 as=0.1113 ps=1.37 w=0.42 l=0.15
X9 VSUBS D VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0.1113 pd=1.37 as=0.0588 ps=0.7 w=0.42 l=0.15
X10 VSUBS li_1523_487# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.6884 pd=20.64 as=0 ps=0 w=0.42 l=0.15
X11 VSUBS li_1523_487# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.42 l=0.15
X12 Y C VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0.3528 pd=4.2 as=0 ps=0 w=0.42 l=0.15
X13 VSUBS C Y VSUBS sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.42 l=0.15
X14 Y m1_860_560# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.42 l=0.15
X15 VSUBS m1_860_560# Y VSUBS sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.42 l=0.15
X16 VSUBS F VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.42 l=0.15
X17 VSUBS F VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.42 l=0.15
X18 Y E VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0.0588 pd=0.7 as=0.1113 ps=1.37 w=0.42 l=0.15
X19 VSUBS E Y VSUBS sky130_fd_pr__nfet_01v8 ad=0.1113 pd=1.37 as=0.0588 ps=0.7 w=0.42 l=0.15
X20 Y E m1_828_2996# m1_828_2996# sky130_fd_pr__pfet_01v8 ad=0.0588 pd=0.7 as=0.1113 ps=1.37 w=0.42 l=0.15
X21 m1_828_2996# E Y m1_828_2996# sky130_fd_pr__pfet_01v8 ad=0.1113 pd=1.37 as=0.0588 ps=0.7 w=0.42 l=0.15
X22 Y F m1_828_2996# m1_828_2996# sky130_fd_pr__pfet_01v8 ad=0.2352 pd=2.8 as=0 ps=0 w=0.42 l=0.15
X23 m1_828_2996# F Y m1_828_2996# sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.42 l=0.15
C0 C D 0.01fF
C1 E m1_828_2996# 1.37fF
C2 B Y 0.00fF
C3 B F 0.00fF
C4 E VN 0.03fF
C5 m1_828_2996# li_1523_487# 0.14fF
C6 VN m1_828_2996# 1.30fF
C7 Y VP 0.14fF
C8 F VP 0.00fF
C9 Y m1_860_560# 0.12fF
C10 B C 0.00fF
C11 A m1_828_2996# 0.14fF
C12 A li_1523_487# 0.28fF
C13 VN A 0.06fF
C14 E Y 0.34fF
C15 E F 0.01fF
C16 E D 0.03fF
C17 B VP 0.31fF
C18 Y m1_828_2996# 4.11fF
C19 m1_828_2996# F 1.95fF
C20 Y li_1523_487# 0.00fF
C21 VN Y 1.00fF
C22 VN F 0.10fF
C23 E C 0.00fF
C24 m1_828_2996# D 1.70fF
C25 A Y 0.01fF
C26 A F 0.00fF
C27 VN D 0.12fF
C28 A D 0.00fF
C29 m1_828_2996# C 1.45fF
C30 VN C 0.05fF
C31 B VN 0.04fF
C32 Y F 0.39fF
C33 B A 0.00fF
C34 Y D 0.12fF
C35 F D 0.05fF
C36 m1_828_2996# VP 0.22fF
C37 m1_828_2996# m1_860_560# 0.01fF
C38 m1_828_2996# DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# 1.63fF
C39 VN VP 0.87fF
C40 m1_860_560# li_1523_487# 0.00fF
C41 li_1523_487# DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# 0.75fF
C42 A VP 0.08fF
C43 Y C 0.13fF
C44 F C 0.06fF
C45 A DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# 0.74fF
C46 Y VSUBS 3.18fF **FLOATING
C47 E VSUBS 1.38fF **FLOATING
C48 m1_828_2996# VSUBS 8.37fF **FLOATING
C49 F VSUBS 0.54fF **FLOATING
C50 m1_860_560# VSUBS 1.05fF **FLOATING
C51 C VSUBS 1.13fF **FLOATING
C52 D VSUBS 0.84fF **FLOATING
C53 li_1523_487# VSUBS 1.34fF **FLOATING
C54 DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# VSUBS 3.45fF **FLOATING

```
## Modified spice with .lib definition and pre-layout excitations 
```
** sch_path: /home/rahul/Documents/function/function_top.sch
**.subckt function_top A B Y D C F E
*.ipin A
*.ipin B
*.opin Y
*.ipin D
*.ipin C
*.ipin F
*.ipin E
*.option scale=1e-9


X27 VDD A B D C F E Y GND function_skeleton
V1 VDD GND 1.8
.save i(v1)
VA A GND pulse(0 1.8 0 10ps 10ps 1ns 2ns)
.save i(va)
VB B GND pulse(0 1.8 0.1ns 10ps 10ps 1ns 2ns)
.save i(vb)
VC C GND pulse(0 1.8 0.2ns 10ps 10ps 1ns 2ns)
.save i(vc)
VF F GND pulse(0 1.8 0.5ns 10ps 10ps 1ns 2ns)
.save i(vf)
VD D GND pulse(0 1.8 0.3ns 10ps 10ps 1ns 2ns)
.save i(vd)
VE E GND pulse(0 1.8 0.4ns 10ps 10ps 1ns 2ns)
.save i(ve)
**** begin user architecture code

** opencircuitdesign pdks install
.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt



.tran 0.01n 10n
.save all

**** end user architecture code
**.ends

* expanding   symbol:  /home/rahul/Documents/function/function_skeleton.sym # of pins=9
** sym_path: /home/rahul/Documents/function/function_skeleton.sym
** sch_path: /home/rahul/Documents/function/function_skeleton.sch
.subckt function_skeleton VP A B D C F E Y VN
*.ipin A
*.ipin B
*.ipin C
*.ipin D
*.ipin E
*.ipin F
*.iopin VP
*.iopin VN
*.opin Y


X0 m1_828_2996# C m1_828_2996# m1_828_2996# sky130_fd_pr__pfet_01v8 ad=0.0588 pd=0.7 as=0.1113 ps=1.37 w=0.42 l=0.15
X1 m1_828_2996# C m1_828_2996# m1_828_2996# sky130_fd_pr__pfet_01v8 ad=0.1113 pd=1.37 as=0.0588 ps=0.7 w=0.42 l=0.15
X2 m1_828_2996# D m1_828_2996# m1_828_2996# sky130_fd_pr__pfet_01v8 ad=1.3608 pd=16.56 as=0 ps=0 w=0.42 l=0.15
X3 m1_828_2996# D m1_828_2996# m1_828_2996# sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.42 l=0.15
X4 DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# li_1523_487# m1_828_2996# DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# sky130_fd_pr__pfet_01v8 ad=0.1113 pd=1.37 as=0.0588 ps=0.7 w=0.42 l=0.15
X5 m1_828_2996# A DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# sky130_fd_pr__pfet_01v8 ad=0.0588 pd=0.7 as=0.1113 ps=1.37 w=0.42 l=0.15
X6 DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# A m1_828_2996# DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# sky130_fd_pr__pfet_01v8 ad=0.0588 pd=0.7 as=0.0588 ps=0.7 w=0.42 l=0.15
X7 m1_828_2996# li_1523_487# DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# sky130_fd_pr__pfet_01v8 ad=0.0588 pd=0.7 as=0.0588 ps=0.7 w=0.42 l=0.15
X8 VSUBS D VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0.0588 pd=0.7 as=0.1113 ps=1.37 w=0.42 l=0.15
X9 VSUBS D VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0.1113 pd=1.37 as=0.0588 ps=0.7 w=0.42 l=0.15
X10 VSUBS li_1523_487# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.6884 pd=20.64 as=0 ps=0 w=0.42 l=0.15
X11 VSUBS li_1523_487# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.42 l=0.15
X12 Y C VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0.3528 pd=4.2 as=0 ps=0 w=0.42 l=0.15
X13 VSUBS C Y VSUBS sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.42 l=0.15
X14 Y m1_860_560# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.42 l=0.15
X15 VSUBS m1_860_560# Y VSUBS sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.42 l=0.15
X16 VSUBS F VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.42 l=0.15
X17 VSUBS F VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.42 l=0.15
X18 Y E VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0.0588 pd=0.7 as=0.1113 ps=1.37 w=0.42 l=0.15
X19 VSUBS E Y VSUBS sky130_fd_pr__nfet_01v8 ad=0.1113 pd=1.37 as=0.0588 ps=0.7 w=0.42 l=0.15
X20 Y E m1_828_2996# m1_828_2996# sky130_fd_pr__pfet_01v8 ad=0.0588 pd=0.7 as=0.1113 ps=1.37 w=0.42 l=0.15
X21 m1_828_2996# E Y m1_828_2996# sky130_fd_pr__pfet_01v8 ad=0.1113 pd=1.37 as=0.0588 ps=0.7 w=0.42 l=0.15
X22 Y F m1_828_2996# m1_828_2996# sky130_fd_pr__pfet_01v8 ad=0.2352 pd=2.8 as=0 ps=0 w=0.42 l=0.15
X23 m1_828_2996# F Y m1_828_2996# sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.42 l=0.15
C0 D F 0.05fF
C1 B F 0.00fF
C2 F E 0.01fF
C3 VN Y 1.00fF
C4 C m1_828_2996# 1.45fF
C5 A DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# 0.74fF
C6 VN A 0.06fF
C7 m1_860_560# Y 0.12fF
C8 li_1523_487# DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# 0.75fF
C9 m1_828_2996# F 1.95fF
C10 C F 0.06fF
C11 VN VP 0.87fF
C12 Y A 0.01fF
C13 VN D 0.12fF
C14 VN B 0.04fF
C15 VN E 0.03fF
C16 Y VP 0.14fF
C17 D Y 0.12fF
C18 li_1523_487# Y 0.00fF
C19 Y B 0.00fF
C20 Y E 0.34fF
C21 m1_860_560# li_1523_487# 0.00fF
C22 A VP 0.08fF
C23 m1_828_2996# DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# 1.63fF
C24 D A 0.00fF
C25 li_1523_487# A 0.28fF
C26 B A 0.00fF
C27 VN m1_828_2996# 1.30fF
C28 VN C 0.05fF
C29 B VP 0.31fF
C30 Y m1_828_2996# 4.11fF
C31 C Y 0.13fF
C32 D E 0.03fF
C33 m1_860_560# m1_828_2996# 0.01fF
C34 VN F 0.10fF
C35 m1_828_2996# A 0.14fF
C36 Y F 0.39fF
C37 m1_828_2996# VP 0.22fF
C38 D m1_828_2996# 1.70fF
C39 C D 0.01fF
C40 li_1523_487# m1_828_2996# 0.14fF
C41 C B 0.00fF
C42 m1_828_2996# E 1.37fF
C43 F A 0.00fF
C44 C E 0.00fF
C45 F VP 0.00fF
C46 Y VSUBS 3.18fF 
**FLOATING
C47 E VSUBS 1.38fF 
**FLOATING
C48 m1_828_2996# VSUBS 8.37fF 
**FLOATING
C49 F VSUBS 0.54fF 
**FLOATING
C50 m1_860_560# VSUBS 1.05fF 
**FLOATING
C51 C VSUBS 1.13fF 
**FLOATING
C52 D VSUBS 0.84fF 
**FLOATING
C53 li_1523_487# VSUBS 1.34fF 
**FLOATING
C54 DP_PMOS_97285605_X1_Y1_1677097896_0/w_0_0# VSUBS 3.45fF 
**FLOATING
.ends

.GLOBAL VDD
.GLOBAL GND

.end

```
## Generated output with ngspice
![Screenshot from 2023-02-22 23-25-23](https://user-images.githubusercontent.com/50217106/220988709-f1c922b8-dc78-44af-a005-2ebd555c86f0.png)

## ALIGN - Analog Layout, Intelligently Generated from Netlists
### well. not so intelligent

## MAJOR FINDING - the layout generated by ALIGN depends upon the order in which FETs are present in .spice

The layout that ALIGN generates, hugely depenmds on the order in which PFETs and NFETs are present in the .sp file which depends on the order in which PFETs and NFETs are present in the .spice geenrated from xschem.
The order in which FETs are present in .spice from xschem depends directly on the order in which you imported components when you made the schematic. So, if you imported 5 PFETs followed by a single NFET the spice generated will contain 5PFETs followed by a single NFET in the .subckt definition. The.sp will be the same as .spice ( we can manipulate .sp to get a layout from ALIGN that when simulated gives the correct results, but it's not feasible for large designs with many fets). Even though the .sp with differently ordered PFETs and NFETs correspond to the same circuit, ALIGn treats them differently.

For example - In the Function done using ALIGN previously - we have 12 FETs - 6 NFETs and 6 PFETs, the .spice generated from xschem has following subcktg definition of Function:

```
.subckt function_skeleton VP A B D C F E Y VN
*.PININFO A:I B:I C:I D:I E:I F:I VP:B VN:B Y:O
XM44 Y E net2 net2 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM45 net2 F VN VN sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM46 Y A net1 net1 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM47 net3 D net5 net5 sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM48 Y C net1 net1 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM49 net1 B VN VN sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM50 net1 D VN VN sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM51 net3 C net4 net4 sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM52 net4 A VP VP sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM53 net5 B VP VP sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM54 Y E net3 net3 sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM55 Y F net3 net3 sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
.ends
```

Observe the order of FETs -> nfet, nfet, nfet, pfet, nfet, nfet, nfet, pfet, pfet, pfet, pfet, pfet
This is the exact same order in which FETs were imported to xschem window for making the schematic. When corresponding .sp is fed to ALIGN the following layout is generated(when read in MAGIC) -
![Screenshot from 2023-02-22 16-22-35](https://user-images.githubusercontent.com/50217106/220989315-55838255-6551-4055-8969-7afa9e60cdb2.png)

#### BY observing multiple repos with correct results for Function -> It was observed that they had the following pattern of FETs - The presence of FETs were in two collections where PFETs formed one collection and NFEts formed another collection. With discussion it was revealed that they had imported all PFEs at once to xschem and all NFETs at once to xschem. Going with this observation, I performed Function experiments once again, only this time I imported all pfets at once and all nfets at once.

### Function schematic and Testbench and simulation
![Screenshot from 2023-03-03 14-22-19](https://user-images.githubusercontent.com/50217106/222678403-ee12934d-4e5e-4393-a42a-86b564df7a25.png)
![Screenshot from 2023-03-03 00-52-51](https://user-images.githubusercontent.com/50217106/222678438-693587b4-1d60-46ae-94f7-e3caad7d7232.png)
![Screenshot from 2023-03-03 00-54-35](https://user-images.githubusercontent.com/50217106/222678544-28562bb8-cae8-4648-9b88-3df6ec676a57.png)
![Screenshot from 2023-03-03 00-55-28](https://user-images.githubusercontent.com/50217106/222678592-4364a915-4a90-41fd-90fd-4d99e4b5c9d2.png)

### .spice generated - Observe the order of FETs in the .subckt description - all PFETs followed by all nfets - in the exact order they were imported to xschem
```
** sch_path: /home/rahul/Documents/func1/funcTop.sch
.subckt funcTop B A D C F E out A B C D F E
*.PININFO B:I A:I D:I C:I F:I E:I out:O A:I B:I C:I D:I F:I E:I
x1 VDD B A D C F E out GND func1
V1 B GND pulse(0 1.8 0.1n 10p 10p 1n 2n)
.save i(v1)
V2 A GND pulse(0 1.8 0 10p 10p 1n 2n)
.save i(v2)
V3 C GND pulse(0 1.8 0.2n 10p 10p 1n 2n)
.save i(v3)
V4 D GND pulse(0 1.8 0.3n 10p 10p 1n 2n)
.save i(v4)
V5 E GND pulse(0 1.8 0.4n 10p 10p 1n 2n)
.save i(v5)
V6 F GND pulse(0 1.8 0.5n 10p 10p 1n 2n)
.save i(v6)
V7 VDD GND 1.8
.save i(v7)
**** begin user architecture code

.param mc_mm_switch=0
.param mc_pr_switch=0
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/corners/tt.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/r+c/res_typical__cap_typical.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/r+c/res_typical__cap_typical__lin.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/corners/tt/specialized_cells.spice


.tran 0.01n 20n
.save all

**** end user architecture code
.ends

* expanding   symbol:  /home/rahul/Documents/func1/func1.sym # of pins=9
** sym_path: /home/rahul/Documents/func1/func1.sym
** sch_path: /home/rahul/Documents/func1/func1.sch
.subckt func1 VDD B A D C F E out GND
*.PININFO VDD:B GND:B A:I B:I C:I D:I F:I E:I out:O
XM1 net2 B VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM2 net1 A VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM3 net3 C net1 net1 sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM4 net3 D net2 net2 sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM5 out E net3 net3 sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM6 out F net3 net3 sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM7 out E net5 net5 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM8 out C net4 net4 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM9 out A net4 net4 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM10 net4 B GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM11 net4 D GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM12 net5 F GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
.ends

.GLOBAL GND
.GLOBAL VDD
.end
```

### .sp from .spice

 ```
 .subckt func1 VDD B A D C F E out GND
*.PININFO VDD:B GND:B A:I B:I C:I D:I F:I E:I out:O
XM1 net2 B VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=4
XM2 net1 A VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=4
XM3 net3 C net1 net1 sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=4
XM4 net3 D net2 net2 sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=4
XM5 out E net3 net3 sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=4
XM6 out F net3 net3 sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=4
XM7 out E net5 net5 sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
XM8 out C net4 net4 sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
XM9 out A net4 net4 sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
XM10 net4 B GND GND sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
XM11 net4 D GND GND sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
XM12 net5 F GND GND sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
.ends func1
```

### Generated GDS viewed in klayout --- Notice the difference in Layout
![Screenshot from 2023-03-03 01-10-43](https://user-images.githubusercontent.com/50217106/222680711-233d98a6-c045-49ff-bbf4-f5108ae687d0.png)


### Generated GDS read in Magic --- Notice the difference in layout, also Note that ALIGN has generated a layout with DRCs.

![Screenshot from 2023-03-03 01-15-15](https://user-images.githubusercontent.com/50217106/222680730-843b79e5-1a4d-418e-a19a-cad74adf40ec.png)
![Screenshot from 2023-03-03 12-51-21](https://user-images.githubusercontent.com/50217106/222680747-0f8d861a-c445-4d57-9ef3-b536ffb212f7.png)

After corrrecting the DRCs the layout is saved amd extracted 
 ![Screenshot from 2023-03-03 12-57-56](https://user-images.githubusercontent.com/50217106/222682143-dadaca3b-0d01-4fa9-8ede-7b18097c21e5.png)
 
 ```
 extract all
 ext2spice cthresh 0 rthresh 0
 ext2spice
 ```

### .spice generated from magic
```
X0 VDD F m1_602_1232# VDD sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X1 m1_602_1232# F VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X2 VDD F m1_602_1232# VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X3 m1_602_1232# F VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X4 VDD D VDD VDD sky130_fd_pr__pfet_01v8 ad=7.1925 pd=66.2 as=0 ps=0 w=1.05 l=0.15
X5 VDD D VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X6 VDD D VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X7 VDD D VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X8 VDD C VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X9 VDD C VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X10 VDD C VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X11 VDD C VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X12 OUT m1_1462_3164# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X13 GND m1_1462_3164# OUT GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X14 OUT m1_1462_3164# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X15 GND m1_1462_3164# OUT GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X16 GND m1_1086_3248# GND GND sky130_fd_pr__nfet_01v8 ad=7.392 pd=68.68 as=0 ps=0 w=1.05 l=0.15
X17 GND m1_1086_3248# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X18 GND m1_1086_3248# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X19 GND m1_1086_3248# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X20 OUT INV_21710508_0_0_1677786008_0/m1_226_560# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X21 GND INV_21710508_0_0_1677786008_0/m1_226_560# OUT GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X22 OUT INV_21710508_0_0_1677786008_0/m1_226_560# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X23 GND INV_21710508_0_0_1677786008_0/m1_226_560# OUT GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X24 VDD INV_21710508_0_0_1677786008_0/m1_226_560# OUT VDD sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X25 OUT INV_21710508_0_0_1677786008_0/m1_226_560# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X26 VDD INV_21710508_0_0_1677786008_0/m1_226_560# OUT VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X27 OUT INV_21710508_0_0_1677786008_0/m1_226_560# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X28 VDD m1_1086_3248# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X29 VDD m1_1462_3164# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X30 VDD m1_1086_3248# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X31 VDD m1_1462_3164# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X32 VDD m1_1086_3248# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X33 VDD m1_1086_3248# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X34 VDD m1_1462_3164# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X35 VDD m1_1462_3164# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X36 OUT C GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X37 GND C OUT GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X38 OUT C GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X39 GND C OUT GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X40 GND F GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X41 GND F GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X42 GND F GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X43 GND F GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X44 GND li_1437_5023# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X45 GND li_1437_5023# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X46 GND li_1437_5023# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X47 GND li_1437_5023# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
C0 m1_1462_3164# E 0.01fF
C1 m1_1086_3248# VDD 2.28fF
C2 C li_1437_5023# 0.47fF
C3 m1_1086_3248# m1_1462_3164# 0.87fF
C4 m1_1462_3164# VDD 1.64fF
C5 C F 0.00fF
C6 F E 0.00fF
C7 B VDD 0.20fF
C8 VDD li_1437_5023# 0.08fF
C9 m1_1086_3248# F 0.04fF
C10 F VDD 1.94fF
C11 F m1_1462_3164# 0.00fF
C12 OUT A 0.52fF
C13 B F 0.01fF
C14 m1_602_1232# OUT 0.00fF
C15 A E 0.04fF
C16 D OUT 0.05fF
C17 VDD A 0.13fF
C18 C OUT 0.20fF
C19 C D 0.67fF
C20 OUT E 0.06fF
C21 OUT INV_21710508_0_0_1677786008_0/m1_226_560# 0.69fF
C22 D E 0.00fF
C23 D INV_21710508_0_0_1677786008_0/m1_226_560# 0.00fF
C24 B A 0.01fF
C25 m1_602_1232# m1_1086_3248# 0.00fF
C26 m1_1086_3248# OUT 0.04fF
C27 m1_602_1232# VDD 1.55fF
C28 m1_1086_3248# D 0.00fF
C29 OUT VDD 3.70fF
C30 D VDD 1.72fF
C31 F A 0.00fF
C32 m1_602_1232# m1_1462_3164# 0.00fF
C33 m1_1462_3164# OUT 0.99fF
C34 m1_1462_3164# D 0.00fF
C35 m1_1086_3248# C 0.00fF
C36 B OUT 0.14fF
C37 OUT li_1437_5023# 0.01fF
C38 m1_1086_3248# E 0.01fF
C39 C VDD 1.82fF
C40 VDD E 0.16fF
C41 m1_602_1232# F 0.21fF
C42 INV_21710508_0_0_1677786008_0/m1_226_560# VDD 1.65fF
C43 F OUT 0.01fF
C44 C m1_1462_3164# 0.00fF
C45 A GND 0.40fF
C46 B GND 0.56fF
C47 E GND 0.00fF
C48 VDD GND 23.57fF 
**FLOATING
C49 li_1437_5023# GND 1.56fF 
**FLOATING
C50 OUT GND 2.40fF 
**FLOATING
C51 INV_21710508_0_0_1677786008_0/m1_226_560# GND 1.79fF 
**FLOATING
C52 m1_1086_3248# GND 3.49fF 
**FLOATING
C53 m1_1462_3164# GND 2.57fF 
**FLOATING
C54 C GND 1.28fF 
**FLOATING
C55 m1_602_1232# GND 0.48fF 
**FLOATING
C56 F GND 1.89fF 
**FLOATING

```

### Final .spice after adding pre-layout excitations and library definitions

```
 x1 VDD B A D C F E out GND func1
V1 B GND pulse(0 1.8 0.1n 10p 10p 1n 2n)
.save i(v1)
V2 A GND pulse(0 1.8 0 10p 10p 1n 2n)
.save i(v2)
V3 C GND pulse(0 1.8 0.2n 10p 10p 1n 2n)
.save i(v3)
V4 D GND pulse(0 1.8 0.3n 10p 10p 1n 2n)
.save i(v4)
V5 E GND pulse(0 1.8 0.4n 10p 10p 1n 2n)
.save i(v5)
V6 F GND pulse(0 1.8 0.5n 10p 10p 1n 2n)
.save i(v6)
V7 VDD GND 1.8
.save i(v7)



**** begin user architecture code

.param mc_mm_switch=0
.param mc_pr_switch=0
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/corners/tt.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/r+c/res_typical__cap_typical.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/r+c/res_typical__cap_typical__lin.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/corners/tt/specialized_cells.spice

.tran 0.01n 20n
.save all

.subckt func1 VDD B A D C F E out GND
X0 VDD F m1_602_1232# VDD sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X1 m1_602_1232# F VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X2 VDD F m1_602_1232# VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X3 m1_602_1232# F VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X4 VDD D VDD VDD sky130_fd_pr__pfet_01v8 ad=7.1925 pd=66.2 as=0 ps=0 w=1.05 l=0.15
X5 VDD D VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X6 VDD D VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X7 VDD D VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X8 VDD C VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X9 VDD C VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X10 VDD C VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X11 VDD C VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X12 OUT m1_1462_3164# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X13 GND m1_1462_3164# OUT GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X14 OUT m1_1462_3164# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X15 GND m1_1462_3164# OUT GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X16 GND m1_1086_3248# GND GND sky130_fd_pr__nfet_01v8 ad=7.392 pd=68.68 as=0 ps=0 w=1.05 l=0.15
X17 GND m1_1086_3248# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X18 GND m1_1086_3248# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X19 GND m1_1086_3248# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X20 OUT INV_21710508_0_0_1677786008_0/m1_226_560# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X21 GND INV_21710508_0_0_1677786008_0/m1_226_560# OUT GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X22 OUT INV_21710508_0_0_1677786008_0/m1_226_560# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X23 GND INV_21710508_0_0_1677786008_0/m1_226_560# OUT GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X24 VDD INV_21710508_0_0_1677786008_0/m1_226_560# OUT VDD sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X25 OUT INV_21710508_0_0_1677786008_0/m1_226_560# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X26 VDD INV_21710508_0_0_1677786008_0/m1_226_560# OUT VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X27 OUT INV_21710508_0_0_1677786008_0/m1_226_560# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X28 VDD m1_1086_3248# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X29 VDD m1_1462_3164# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X30 VDD m1_1086_3248# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X31 VDD m1_1462_3164# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X32 VDD m1_1086_3248# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X33 VDD m1_1086_3248# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X34 VDD m1_1462_3164# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X35 VDD m1_1462_3164# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X36 OUT C GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X37 GND C OUT GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X38 OUT C GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X39 GND C OUT GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X40 GND F GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X41 GND F GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X42 GND F GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X43 GND F GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X44 GND li_1437_5023# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X45 GND li_1437_5023# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X46 GND li_1437_5023# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X47 GND li_1437_5023# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
C0 m1_1462_3164# E 0.01fF
C1 m1_1086_3248# VDD 2.28fF
C2 C li_1437_5023# 0.47fF
C3 m1_1086_3248# m1_1462_3164# 0.87fF
C4 m1_1462_3164# VDD 1.64fF
C5 C F 0.00fF
C6 F E 0.00fF
C7 B VDD 0.20fF
C8 VDD li_1437_5023# 0.08fF
C9 m1_1086_3248# F 0.04fF
C10 F VDD 1.94fF
C11 F m1_1462_3164# 0.00fF
C12 OUT A 0.52fF
C13 B F 0.01fF
C14 m1_602_1232# OUT 0.00fF
C15 A E 0.04fF
C16 D OUT 0.05fF
C17 VDD A 0.13fF
C18 C OUT 0.20fF
C19 C D 0.67fF
C20 OUT E 0.06fF
C21 OUT INV_21710508_0_0_1677786008_0/m1_226_560# 0.69fF
C22 D E 0.00fF
C23 D INV_21710508_0_0_1677786008_0/m1_226_560# 0.00fF
C24 B A 0.01fF
C25 m1_602_1232# m1_1086_3248# 0.00fF
C26 m1_1086_3248# OUT 0.04fF
C27 m1_602_1232# VDD 1.55fF
C28 m1_1086_3248# D 0.00fF
C29 OUT VDD 3.70fF
C30 D VDD 1.72fF
C31 F A 0.00fF
C32 m1_602_1232# m1_1462_3164# 0.00fF
C33 m1_1462_3164# OUT 0.99fF
C34 m1_1462_3164# D 0.00fF
C35 m1_1086_3248# C 0.00fF
C36 B OUT 0.14fF
C37 OUT li_1437_5023# 0.01fF
C38 m1_1086_3248# E 0.01fF
C39 C VDD 1.82fF
C40 VDD E 0.16fF
C41 m1_602_1232# F 0.21fF
C42 INV_21710508_0_0_1677786008_0/m1_226_560# VDD 1.65fF
C43 F OUT 0.01fF
C44 C m1_1462_3164# 0.00fF
C45 A GND 0.40fF
C46 B GND 0.56fF
C47 E GND 0.00fF
C48 VDD GND 23.57fF 
**FLOATING
C49 li_1437_5023# GND 1.56fF 
**FLOATING
C50 OUT GND 2.40fF 
**FLOATING
C51 INV_21710508_0_0_1677786008_0/m1_226_560# GND 1.79fF 
**FLOATING
C52 m1_1086_3248# GND 3.49fF 
**FLOATING
C53 m1_1462_3164# GND 2.57fF 
**FLOATING
C54 C GND 1.28fF 
**FLOATING
C55 m1_602_1232# GND 0.48fF 
**FLOATING
C56 F GND 1.89fF 
**FLOATING
.ends

.GLOBAL VDD
.GLOBAL GND

.end

```


### Obtained simulations

![Screenshot from 2023-03-03 14-54-57](https://user-images.githubusercontent.com/50217106/222683327-b5ccaf03-2162-4586-94b8-40c6028defde.png)

![Screenshot from 2023-03-03 13-09-15](https://user-images.githubusercontent.com/50217106/222683354-f449915c-d58e-41a2-aefd-d2bc101dacd0.png)


-------------------------------------------------------------------

## openFASOC
openFASOC is a project focused on automated analog generation from user specification to GDSII with fully open-sourced tools. It is inspired from FASoC which sits on proprietary software. FASoC: Fully-Autonomous SoC Synthesis using Customizable Cell-Based Synthesizable Analog Circuits. The FASoC Program is focused on developing a complete system-on-chip(SoC) synthesis tool from user specification to GDSII. FASoC leverages a differentiating technology to automatically synthesize "correct-by-construction" Verilog descriptions for both analog and digital circuits and nable a protable, single pass implementation flow. The SoC synthesis tool realizes analog circuits, including PLLs, power management, ADCs, and sensor interfaces by recasting them as structures composed largely of digital components while maintaining analog performance. They are then expressed as synthesizable Verilog blocks composed of digital standard cells augmented with a few auxilliary cells generated with an automatic cell generation tool. This project is led by a team of researchers at the Universities of Michigan, Virginia,a nd ARM.

## Installation of openFASOC
```
$ git clone https://github.com/idea-fasoc/openfasoc
$ sudo ./dependencies.sh
```
## Run OpenFASOC 
Go to one of the generators in openfasoc and open the terminal there, then use "make". All the generator specific targets are listed.
![Screenshot from 2023-02-24 22-52-36](https://user-images.githubusercontent.com/50217106/221419872-ae748f29-6d7b-4e79-b8f3-d347391ccc26.png)

## Yosys
Yosys is  aframework for for Verilog RTL Synthesis. It currently has extensive Verilog-2005 support and provides a basic set of synthesis algorithms for various application domains. Yosys can be adapted to perform any synthesis job by combinign the existing passes(algorithms) using synthesis scripts and adding additional passes as needed by extending the Yosys C++ code base. Yosys is controlled using Synthesis scripts
## Installation of Yosys
Packages needed by Yosys
```
$ sudo apt install -y clang bison flex \
    libreadline-dev gawk tcl-dev libffi-dev git \
    graphviz xdot pkg-config python3 libboost-system-dev \
    libboost-python-dev libboost-filesystem-dev zlib1g-dev
```
### Installation
```
$ git clone https://github.com/YosysHQ/yosys.git
$ cd yosys
$ make
$ sudo make install
```
When make executes the execution may get stuck and continuously iterate showing a single warning - 

![Screenshot from 2023-02-26 16-12-13](https://user-images.githubusercontent.com/50217106/221416529-3e3888c9-ff28-406a-b97f-a756ca7b377a.png)
Here the build process enters into a detached head state. To resume build process, run the following in a separate terminal.
```
git config --global advice.detached head false
```

## OpenROAD
OpenROAD is a foundational building block in open-source digital flow like OpenROAD-flow-scripts, OpenLANE from Efabless, Silicon Compiler Systems; as well as OpenFASoC for mixed-signal design flow. OpenROAD is an open-source software development platform for designing and optimizing integrated circuits (ICs). It is a full RTL-to-GDSII (Register Transfer Level to Graphic Data System II) implementation flow that includes tools for design, synthesis, placement, routing, timing analysis, and verification.
- Problem: Hardware design requires too much effort, cost and time.
- Challenge: Costs and the “expertise gap” block system designers’ access to advanced technology.
- Objective:  Enable no-human-in-loop, 24-hour design to remove the barrier to hardware innovation

## Installtion of OpenROAD
```
cd
git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD.git
cd OpenROAD
sudo ./etc/DependencyInstaller.sh                      //Dependencies need some superuser permissions
cd
git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts
cd OpenROAD-flow-scripts
./build_openroad.sh –local
```
## Testing installation of OpenROAD
We perform RTL2GDS of ibex. ibex is a 32 bit RISC-V CPU core ( RV32IMC/EMC ) with a two-stage pipeline. 
```
cd OpenROAD-flow-scripts
cd flow
make DESIGN_CONFIG=./designs/sky130hd/ibex/config.mk
```
![Screenshot from 2023-02-26 16-40-11](https://user-images.githubusercontent.com/50217106/221414408-2727fef3-905a-43f6-bd9f-720ccf99e506.png)

![Screenshot from 2023-02-26 16-59-39](https://user-images.githubusercontent.com/50217106/221416830-ded37c1c-1c7c-44ff-ab04-8395baf46e01.png)

### SDCs used for ibex 
![Screenshot from 2023-02-26 17-23-56](https://user-images.githubusercontent.com/50217106/221421344-5ecf8b2c-d472-445f-9887-832f0cd26d04.png)
### GDS view of ibex on klayout
![Screenshot from 2023-02-26 17-18-00](https://user-images.githubusercontent.com/50217106/221421360-5dac2fc8-00e0-473d-ba9e-28d0ef982b21.png)
![Screenshot from 2023-02-26 17-21-24](https://user-images.githubusercontent.com/50217106/221421367-a28a638d-905a-446a-adab-f6a57e576725.png)
To view ibex using OpenROAD's GUI
```
$ make DESIGN_CONFIG=./designs/sky130hd/ibex/config.mk gui_final
```
![Screenshot from 2023-02-26 17-46-08](https://user-images.githubusercontent.com/50217106/221414499-7d4c1d2c-36ee-48aa-80f2-357638f82137.png)

## Temperature sensor Auxilliary Cells
An overview of how the Temperature Sensor Generator (temp-sense-gen) works internally in OpenFASoC

![image](https://user-images.githubusercontent.com/50217106/226996331-2fbb1424-abe5-46a4-bfab-768ce5a7ace0.png)

### Circuit
This generator creates a compact mixed-signal temperature sensor. It consists of a ring oscillator whose frequency is controlled by the voltage drop over a MOSFET operating in subthreshold regime, where its dependency on temperature is exponential.

![image](https://user-images.githubusercontent.com/50217106/221423346-0e487e79-5845-4a6f-a3c1-5ca66f034d7e.png)

The physical implementation of the analog blocks in the circuit is done using two manually designed standard cells:
 1. HEADER cell, containing the transistors in subthreshold operation;
 2. SLC cell, containing the Split-Control Level Converter.
### SLC GDS view in kaylout
![Screenshot from 2023-02-24 21-53-31](https://user-images.githubusercontent.com/50217106/221422058-2938ba4d-ef5f-4497-a935-5a6c6f8f1430.png)
### Header GDS view in klayout
![Screenshot from 2023-02-24 21-52-50](https://user-images.githubusercontent.com/50217106/221422049-b4d49bb9-deb1-44ae-9e06-e137592b9a8e.png)

## Temperature Sensor Generation using OpenFASOC

The default circuit’s physical design generation can be divided into three parts:
- Verilog generation
- RTL-to-GDS flow (OpenROAD)
- Post-layout verification (DRC and LVS)

### Verilog Generation
The platform determines the pdk that will be used by OpenFASOC for the design and it's location is provided by providing the PDK_ROOT environment variable in the ```/openfasoc/generators/temp_sense``` directory

```export PDK_ROOT=/home/rahul/open_pdks/sky130/```

Since OpenFASOC flow needs Yosys for logic synthesis, and OpenROAD for RTL2GDS and post-layout verification, we need to export the PATH and OPENROAD environment variables as below in the ```~/openfasoc/generators/temp_sense``` directory

```
export OPENROAD=~/OpenROAD-flow-scripts/tools/OpenROAD/
export PATH=/home/rahul/OpenROAD-flow-scripts/tools/install/OpenROAD/bin:/home/rahul/OpenROAD-flow-scripts/tools/install/yosys/bin:/home/rahul/OpenROAD-flow-scripts/tools/install/LSOracle/bin:$PATH
```

To generate verilog, type the command ```make sky130hd_temp_verilog```
![Screenshot from 2023-02-26 21-29-13](https://user-images.githubusercontent.com/50217106/221421589-717aedf0-c2c1-4acf-90b6-da178d9d6e64.png)

To build the default generator(temp_sense), ```cd``` into ```~/openfasoc/generators/temp_sense``` and use 
```make sky130hd_temp```

After a successful run the following message is displayed

![Screenshot from 2023-02-26 14-08-37](https://user-images.githubusercontent.com/50217106/221420486-877d2b7a-b937-41f8-a129-cee7dbeae548.png)

In the following directory all the files corresponding to different stages of the RTL2GDS flow is saved.

![Screenshot from 2023-02-26 17-53-39](https://user-images.githubusercontent.com/50217106/221422433-ee88f14f-24be-45f7-8a4a-0b1bea51b39c.png)

Viewing the GDS view of the temperature generator using klayout-

![Screenshot from 2023-02-26 17-50-19](https://user-images.githubusercontent.com/50217106/221420863-1664b395-33bf-4a11-a679-04900a5aa84b.png)

For debugging purposes, it is also possible to generate only part of the flow, visualize the results in OpenROAD GUI or generate DEF files of all intermediary results. For doing so, the Makefile in ```temp-sense-gen/flow/``` contains special targets. After running ```make sky130hd_temp``` in ```/openfasoc/openfasoc/generators/temp-sense-gen/``` once, cd into the ```/openfasoc/openfasoc/generators/temp-sense-gen/flow/``` directory and use one of the commands from the following table.

| Command | Description |
| --- | --- |
| make synth | Stops the flow after synthesis |
| make floorplan | Stops the flow after floorplan |
| make place | Stops the flow after placement |
| make route | Stops the flow after routing |
| make finish | Runs the whole RTL-to-GDS flow |
| make gui_floorplan | Opens the design after floorplan in OpenROAD GUI |
| make gui_place | Opens the design after placement in OpenROAD GUI |
| make gui_route | Opens the design after routing in OpenROAD GUI |
| make gui_final | Opens the finished design in OpenROAD GUI |
| make all_defs | creates DEF files in flow/results/ of every step in the flow |
| make print-ENV_VARIABLE_NAME | Prints the value of an env variable recognized by OpenROAD Flow |

#### Reference
- https://openfasoc.readthedocs.io/en/latest/flow-tempsense.html


-------------------------------------------------------------------------
# 4-bit Asynchronous UP counter with OpenFASOC
First we need to generate the GDS of the analog blocks using ALIGN. For the design - 4-bit Asynchronous UP counter we have the ring oscillator and the one-bit ADC.
## GDS generation of Ring-oscillator and verifying layout functionality using NGSPICE

### Ring oscillator schematic and Testbench and Simulation

![Screenshot from 2023-03-03 15-43-43](https://user-images.githubusercontent.com/50217106/222694226-e67ce089-24cd-44cc-871c-eaa41e7fb08d.png)

![Screenshot from 2023-03-03 15-43-26](https://user-images.githubusercontent.com/50217106/222694259-4bc75e31-6153-4831-8dcc-613f06cdda7b.png)

![Screenshot from 2023-03-03 15-44-33](https://user-images.githubusercontent.com/50217106/222694293-c8503a3f-abb7-4e7d-9b5f-cf37bc807aca.png)

![Screenshot from 2023-03-03 15-44-44](https://user-images.githubusercontent.com/50217106/222694442-b38d03c4-ca53-4656-86a9-b585f4b8790b.png)


### .spice RING oscilator
```
** sch_path: /home/rahul/Documents/ring_osc/ringTop.sch
**.subckt ringTop out
*.opin out
x27 VDD out GND ringosc
V1 VDD GND 1.8
.save i(v1)
**** begin user architecture code

** opencircuitdesign pdks install
.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt



.tran 0.01n 10n
.save all

**** end user architecture code
**.ends

* expanding   symbol:  /home/rahul/Documents/ring_osc/ringosc.sym # of pins=3
** sym_path: /home/rahul/Documents/ring_osc/ringosc.sym
** sch_path: /home/rahul/Documents/ring_osc/ringosc.sch
.subckt ringosc VDD out GND
*.opin out
*.iopin VDD
*.iopin GND
XM1 out net2 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM2 out net2 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM3 net2 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM4 net1 out VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM5 net2 net1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM6 net1 out GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends

.GLOBAL VDD
.GLOBAL GND
.end

```

### .sp RING oscillator and ALIGN error when generating GDS
![Screenshot from 2023-03-02 23-30-15](https://user-images.githubusercontent.com/50217106/222692252-3a6f1dd7-db7b-41ce-8b35-06a36aa02466.png)

![Screenshot from 2023-03-02 23-29-48](https://user-images.githubusercontent.com/50217106/222692361-346232a7-93cf-4706-8785-349c4bf578ee.png)

### Manipulations in .sp 
As per the findings in week2 that - ALIGN generates correct Layout when PFETs and NFETs form two collections in the .spice(pfets imported at once and nfets imported at once in xschem) is not completely correct. While making this ring oscillator schematic, this was taken care, still ALIGN gives some error. If this erroneous layout is extrated in magic then the .spice will not have "out" pin. ALIGN is looking for patterns in .sp file for generating layout. 
The .sp file was randomly manipulated until ALIGN stopped giving the error - "Placer warning - terminal 1 is dangling set it to origin"

![Screenshot from 2023-03-02 23-34-45](https://user-images.githubusercontent.com/50217106/222687446-0607c37c-e83c-465e-bfdf-8e4d677d9281.png)
![Screenshot from 2023-03-02 23-46-02](https://user-images.githubusercontent.com/50217106/222687498-ccfb3e99-0474-4294-b028-f536a9315221.png)

### GDS read in Klayout
![Screenshot from 2023-02-27 21-25-34](https://user-images.githubusercontent.com/50217106/222694994-5d5317c5-0d2c-4dcf-9b8a-69ff1742493d.png)
![Screenshot from 2023-02-27 21-35-03](https://user-images.githubusercontent.com/50217106/222695010-96b43f93-2221-4352-9bb5-22bf22134ef2.png)

### GDS read in Magic
![Screenshot from 2023-02-28 01-08-31](https://user-images.githubusercontent.com/50217106/222695026-a5541e3d-c1e6-4909-b51a-faaf6b9f9025.png)


### spice simulation of extracted layout
generated .spice
```

X0 m1_688_4424# li_405_1579# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X1 VSUBS li_405_1579# m1_688_4424# VSUBS sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X2 m1_688_4424# li_405_1579# m1_398_2912# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X3 m1_398_2912# li_405_1579# m1_688_4424# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X4 li_405_1579# STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# m1_398_2912# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X5 m1_398_2912# STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# li_405_1579# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X6 STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# m1_688_4424# m1_398_2912# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=0.294 pd=2.66 as=1.6695 ps=15.78 w=1.05 l=0.15
X7 m1_398_2912# m1_688_4424# STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X8 li_405_1579# STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X9 VSUBS STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# li_405_1579# VSUBS sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X10 STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# m1_688_4424# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0.294 pd=2.66 as=1.6695 ps=15.78 w=1.05 l=0.15
X11 VSUBS m1_688_4424# STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# VSUBS sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
C0 STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# OUT 0.00fF
C1 GND STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# 0.15fF
C2 m1_398_2912# li_405_1579# 2.02fF
C3 m1_688_4424# li_405_1579# 0.44fF
C4 m1_688_4424# m1_398_2912# 2.17fF
C5 li_405_1579# OUT 0.01fF
C6 VDD STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# 0.03fF
C7 GND li_405_1579# 0.14fF
C8 GND OUT 0.02fF
C9 VDD li_405_1579# 1.31fF
C10 m1_688_4424# VDD 0.32fF
C11 VDD OUT 0.24fF
C12 GND VDD 0.24fF
C13 li_405_1579# STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# 0.57fF
C14 m1_398_2912# STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# 3.01fF
C15 m1_688_4424# STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# 0.59fF
C16 VDD VSUBS 0.16fF
C17 m1_688_4424# VSUBS 2.47fF **FLOATING
C18 li_405_1579# VSUBS 1.73fF **FLOATING
C19 STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# VSUBS 0.49fF **FLOATING
C20 m1_398_2912# VSUBS 8.15fF **FLOATING

```
final .spice to ngspice
```
.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt


x1 VDD out GND ringosc
V1 VDD GND 1.8
.save i(v1)
**** begin user architecture code

.tran 0.01n 10n
.save all

.subckt ringosc VDD out GND

X0 m1_688_4424# li_405_1579# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X1 VSUBS li_405_1579# m1_688_4424# VSUBS sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X2 m1_688_4424# li_405_1579# m1_398_2912# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X3 m1_398_2912# li_405_1579# m1_688_4424# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X4 li_405_1579# STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# m1_398_2912# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X5 m1_398_2912# STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# li_405_1579# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X6 STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# m1_688_4424# m1_398_2912# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=0.294 pd=2.66 as=1.6695 ps=15.78 w=1.05 l=0.15
X7 m1_398_2912# m1_688_4424# STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X8 li_405_1579# STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X9 VSUBS STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# li_405_1579# VSUBS sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X10 STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# m1_688_4424# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0.294 pd=2.66 as=1.6695 ps=15.78 w=1.05 l=0.15
X11 VSUBS m1_688_4424# STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# VSUBS sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
C0 GND VDD 0.24fF
C1 GND STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# 0.15fF
C2 GND li_405_1579# 0.14fF
C3 m1_688_4424# m1_398_2912# 2.17fF
C4 OUT VDD 0.24fF
C5 OUT STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# 0.00fF
C6 OUT li_405_1579# 0.01fF
C7 STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# VDD 0.03fF
C8 li_405_1579# VDD 1.31fF
C9 li_405_1579# STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# 0.57fF
C10 STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# m1_398_2912# 3.01fF
C11 m1_688_4424# VDD 0.32fF
C12 li_405_1579# m1_398_2912# 2.02fF
C13 OUT GND 0.02fF
C14 m1_688_4424# STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# 0.59fF
C15 m1_688_4424# li_405_1579# 0.44fF
C16 VDD VSUBS 0.16fF
C17 m1_688_4424# VSUBS 2.47fF 
**FLOATING
C18 li_405_1579# VSUBS 1.73fF 
**FLOATING
C19 STAGE2_INV_60376295_0_0_1677862102_0/li_491_571# VSUBS 0.49fF 
**FLOATING
C20 m1_398_2912# VSUBS 8.15fF 
**FLOATING
.ends

.GLOBAL VDD
.GLOBAL GND
.end
```
simulation

![Screenshot from 2023-02-28 01-24-50](https://user-images.githubusercontent.com/50217106/222695054-17e27079-61ba-4253-8336-7a0cbd285888.png)




### changing nf=2 from nf=10 and simulation
generated .spice 
```

X0 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X1 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X2 GND OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X3 GND OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X4 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X5 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X6 GND OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X7 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X8 GND OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X9 GND OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X10 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=1.47 pd=13.3 as=5.1975 ps=47.7 w=1.05 l=0.15
X11 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X12 GND STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X13 GND STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X14 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X15 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X16 GND STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X17 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X18 GND STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X19 GND STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X20 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X21 VDD OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X22 VDD OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X23 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X24 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X25 VDD OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X26 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X27 VDD OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X28 VDD OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X29 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X30 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=1.47 pd=13.3 as=5.1975 ps=47.7 w=1.05 l=0.15
X31 VDD STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X32 VDD STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X33 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X34 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X35 VDD STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X36 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X37 VDD STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X38 VDD STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X39 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X40 OUT m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X41 OUT m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X42 GND m1_828_1568# OUT GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X43 GND m1_828_1568# OUT GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X44 OUT m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X45 OUT m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X46 GND m1_828_1568# OUT GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X47 OUT m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X48 GND m1_828_1568# OUT GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X49 GND m1_828_1568# OUT GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X50 OUT m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X51 VDD m1_828_1568# OUT VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X52 VDD m1_828_1568# OUT VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X53 OUT m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X54 OUT m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X55 VDD m1_828_1568# OUT VDD sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X56 OUT m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X57 VDD m1_828_1568# OUT VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X58 VDD m1_828_1568# OUT VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X59 OUT m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
C0 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT 1.49fF
C1 VDD m1_828_1568# 7.87fF
C2 OUT VDD 8.55fF
C3 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD 8.51fF
C4 OUT m1_828_1568# 1.84fF
C5 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# 1.83fF
C6 m1_828_1568# GND 6.52fF **FLOATING
C7 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND 5.34fF **FLOATING
C8 VDD GND 17.11fF **FLOATING
C9 OUT GND 6.41fF **FLOATING


```

final .spice to ngspice
```
.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt


x1 VDD out GND ringosc
V1 VDD GND 1.8
.save i(v1)
**** begin user architecture code

.tran 0.01n 10n
.save all

.subckt ringosc VDD out GND
X0 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X1 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X2 GND OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X3 GND OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X4 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X5 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X6 GND OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X7 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X8 GND OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X9 GND OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X10 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=1.47 pd=13.3 as=5.1975 ps=47.7 w=1.05 l=0.15
X11 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X12 GND STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X13 GND STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X14 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X15 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X16 GND STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X17 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X18 GND STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X19 GND STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X20 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X21 VDD OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X22 VDD OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X23 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X24 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X25 VDD OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X26 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X27 VDD OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X28 VDD OUT STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X29 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X30 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=1.47 pd=13.3 as=5.1975 ps=47.7 w=1.05 l=0.15
X31 VDD STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X32 VDD STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X33 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X34 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X35 VDD STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X36 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X37 VDD STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X38 VDD STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X39 m1_828_1568# STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X40 OUT m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X41 OUT m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X42 GND m1_828_1568# OUT GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X43 GND m1_828_1568# OUT GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X44 OUT m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X45 OUT m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X46 GND m1_828_1568# OUT GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X47 OUT m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X48 GND m1_828_1568# OUT GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X49 GND m1_828_1568# OUT GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X50 OUT m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X51 VDD m1_828_1568# OUT VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X52 VDD m1_828_1568# OUT VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X53 OUT m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X54 OUT m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X55 VDD m1_828_1568# OUT VDD sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X56 OUT m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X57 VDD m1_828_1568# OUT VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X58 VDD m1_828_1568# OUT VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X59 OUT m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
C0 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# OUT 1.49fF
C1 VDD m1_828_1568# 7.87fF
C2 OUT VDD 8.55fF
C3 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# VDD 8.51fF
C4 OUT m1_828_1568# 1.84fF
C5 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# m1_828_1568# 1.83fF
C6 m1_828_1568# GND 6.52fF
 **FLOATING
C7 STAGE2_INV_31918392_0_0_1677854023_0/li_1179_1495# GND 5.34fF 
**FLOATING
C8 VDD GND 17.11fF 
**FLOATING
C9 OUT GND 6.41fF 
**FLOATING
.ends

.GLOBAL VDD
.GLOBAL GND
.end


```
![Screenshot from 2023-03-03 20-07-41](https://user-images.githubusercontent.com/50217106/222777203-6545fc26-3502-46c5-9040-125e5ee8b45a.png)

![Screenshot from 2023-03-03 20-31-51](https://user-images.githubusercontent.com/50217106/222777306-ecad681b-036b-42c3-96c0-f251fb337476.png)

![Screenshot from 2023-03-03 20-11-41](https://user-images.githubusercontent.com/50217106/222777239-1d010a34-bdbe-4e41-8804-789a1cb49dce.png)

![Screenshot from 2023-03-03 20-11-52](https://user-images.githubusercontent.com/50217106/222777261-9a53c644-0e3e-4d53-b5e4-1dd8c0e7858f.png)

### Why increasing nf(no. of fingers of MOSFET) gives accurate results?

Ring oscillator generates a periodic-oscillating waveform which oscillates at a frequency that depends on our MOSFET parameters. Lower drain capacitance at FETs(which is a result of intrinsic drain capacitance and wire capacitance) means lower RC during charging or discharging hence faster response. Wider transistor means lower resitance and fatser charging. But wider transistor will have larger instrinsic capacitances. A large instrinsic capacitance means slower charging and discharging times. If the capacitor is not able to completely charge-dicharge it assumes a constant value with time in the presence of continuous excitation, the value slightly attenuated depending on the frequency of operation and hence the constant signal at the output. So, if we reduce width capacitances will be low but resistances will be large and if we increase width capacitances will be high and resistances will be low. To tackle this trade-off we have multi-finger mosfet technique which reduces both capacitances and resistances.

When nf=2 we get a waveform that has value of around 1.7V and is constant with time. It looks like a noise instead of a meaningful signal. 
The width of transistor is fixed to 1050n.The number of fingers =2, refer to the number of fingers in parallel .i.e the width of transistor is divided by nf value
![Screenshot 2023-03-04 025147](https://user-images.githubusercontent.com/50217106/222831926-cb1b81fc-b6fd-4992-af23-f16ffdf17aa7.png)

So, width 1050n will have a large capacitance if nf is low. If we increase nf value, the width of transistor(1050n) is reduced and effective area of transistor is reduced and leads to reduced intrinsic capacitances and resitances(parasitics). This allows the capacitnaces at drain to respond(charge-discharge completely) and hence the proper wave-form at the output when we increase nf value to 10. 

Inferences were drawn from this paper - https://www.sciencedirect.com/science/article/abs/pii/S002627142100411X

------------------------------------------------------------------------

## GDS generation of 1-bit ADC using ALIGN and post-layout simulations with NGSPICE
- Chosen ADC architecture - Flash type  

We use a open-loop OP-AMP which will function as a comparator. To it's non-inverting terminal, we apply the analog input from ring oscillator which is a periodic signal with amplitude 1.8V. This input will be modelled as a sinusoidal source in our schematic. To the inverting terminal, we apply a reference signal of VREF = 0.9V. When analog input is greater than VREF, the output will be positive supply voltage +VCC, resulting in positive saturation at the output. When it is less than VREF, the output will be negative supply voltag(here 0V), resulting in a negative saturation at the output. The output waveform is a 1-bit discrete signal and is our desired 1-bit ADC output.

![ezgif-2-f14b8dd1d5](https://user-images.githubusercontent.com/50217106/225022772-5a5328e0-358e-4b11-9254-6b7dcc2dc1b6.jpg)>

## 2 stage CMOS OPAMP schematic - Testing in Differential Mode

![Screenshot from 2023-03-16 03-50-05](https://user-images.githubusercontent.com/50217106/225456631-bcaaf820-9ed7-49ed-875d-81c96c511e2d.png)

![Screenshot from 2023-03-16 03-49-53](https://user-images.githubusercontent.com/50217106/225456637-59a87e08-137d-4a55-a052-c9f2b5776ac9.png)

It is necessary to size the transistors correctly to get the desired output. For amplifier design, we need to make sure all the transistors are in saturation. Digital sizing techniques are not applicable in CMOS analog design.

## ADC using OPAMP - PreLayout

To provide the reference voltage at inverting terminal of OP-AMP, two diode connected mosfets are used. A diode connected mosfet acts as a resistor of resistance 1/gm (gm = transconductance of FET small signal model) 
Potential at the referene node supposed to be 0.9 is noisy but SNR is small as shown below
![Screenshot from 2023-03-16 03-09-31](https://user-images.githubusercontent.com/50217106/225452408-89c2574b-d5eb-4d24-b33f-27603df8577a.png)

![Screenshot from 2023-03-16 03-11-00](https://user-images.githubusercontent.com/50217106/225452116-20e74258-cbf7-4714-956c-2530546864c4.png)

![Screenshot from 2023-03-15 14-06-41](https://user-images.githubusercontent.com/50217106/225452846-0ad20563-9755-4815-8b50-2913adbee8a4.png)

![Screenshot from 2023-03-16 03-10-54](https://user-images.githubusercontent.com/50217106/225452145-5143c7f1-0f61-4a36-8c4e-abe9ce503c91.png)

![Screenshot from 2023-03-16 03-10-28](https://user-images.githubusercontent.com/50217106/225452172-27879a37-6a7a-4cf7-a287-7a9484524f1c.png)

## OPAMP modifications 
The output of ompamp functioning as comparator will be an input to our digital block in the mixed signal design. There are several techniques used to minimize noise and obtain an ideal input for the digital block. An ideal input has minimum input signal transition(slew), complete signal swing and mimimum or no noise at all. To achive it a chain of inverters are added at the output to act as an interface circuitry and provide a near ideal signal to the digital block.

### xschem schematic
![Screenshot from 2023-03-27 23-56-46](https://user-images.githubusercontent.com/50217106/228069927-3a2dce30-5de4-47fa-999e-4a2a55d273ea.png)
![Screenshot from 2023-03-28 02-41-14](https://user-images.githubusercontent.com/50217106/228069947-54fece19-d64c-4d82-ba99-64c37cfa3fb0.png)

### ngspice simulation

![Screenshot from 2023-03-28 02-55-40](https://user-images.githubusercontent.com/50217106/228070431-50080679-d4a6-4342-9de6-6edfc3f7619c.png)
### Advantage of adding inverter chain
The second output is taken directly from the 2nd stage of TWO stage CMOS Op-Amp. The first one is after using the inverter chain

![Screenshot from 2023-03-20 02-25-07](https://user-images.githubusercontent.com/50217106/228073129-b2a22a07-29f2-4488-b8c0-66090f71ce1b.png)

### pre-layout spice netlist
```
** sch_path: /home/rahul/Documents/adcSingular/adc_tb.sch
**.subckt adc_tb out vin vref vin vref
*.opin out
*.ipin vin
*.ipin vref
*.ipin vin
*.ipin vref
V1 VDD GND 1.8
.save i(v1)
V2 vin GND sin(0.9 0.9 50Meg)
.save i(v2)
V3 vref GND 0.9
.save i(v3)
x1 VDD out vin vref GND adc_flash
**** begin user architecture code

.tran 0.01n 100n
.save all


.param mc_mm_switch=0
.param mc_pr_switch=0
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/corners/tt.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/r+c/res_typical__cap_typical.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/r+c/res_typical__cap_typical__lin.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/corners/tt/specialized_cells.spice

**** end user architecture code
**.ends

* expanding   symbol:  /home/rahul/Documents/adcSingular/adc_flash.sym # of pins=5
** sym_path: /home/rahul/Documents/adcSingular/adc_flash.sym
** sch_path: /home/rahul/Documents/adcSingular/adc_flash.sch
.subckt adc_flash VDD out vin vref GND
*.ipin vin
*.iopin GND
*.opin out
*.iopin VDD
*.ipin vref
XM1 net3 vin net1 GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM2 net2 vref net1 GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM3 net3 net2 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM4 net2 net2 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM7 net1 net4 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM8 net4 net4 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM9 VDD VDD net4 GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM5 net5 net3 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM6 net5 net4 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM10 net6 net5 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM11 net6 net5 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM12 out net6 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM13 out net6 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends

.GLOBAL GND
.GLOBAL VDD
.end

```

---> NOTE - The ADC circuit in the bottom hierarchy has an I/O pin that shows GND pin. DO not name it as VSS or something. It will create problems in post-layout spice simulations. As NGSPICE understands GND and doesn't like any other name for it, even if it is in a subckt

![Screenshot from 2023-03-28 01-23-59](https://user-images.githubusercontent.com/50217106/228070895-d100f490-445d-4f18-a7f2-06f5186c06f3.png)

# ADC layout using ALIGN and postlayout SPICE analysis
- .sp fed to ALIGN  
```
.subckt adc_flash vin GND out VDD vref
XM1 net3 vin net1 GND sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
XM2 net2 vref net1 GND sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
XM3 net3 net2 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=4
XM4 net2 net2 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=4
XM7 net1 net4 GND GND sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
XM8 net4 net4 GND GND sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
XM9 VDD VDD net4 GND sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
XM5 net5 net3 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=4
XM6 net5 net4 GND GND sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
XM10 net6 net5 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=4
XM11 net6 net5 GND GND sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
XM12 out net6 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=4
XM13 out net6 GND GND sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
.ends

```

## GDS view in klayout

![Screenshot from 2023-03-28 03-01-34](https://user-images.githubusercontent.com/50217106/228071572-7456a112-1a89-45da-8211-0543cf5e9e5d.png)

## Import GDS in magic
Remove the ports imported by magic as they are the main source of problem in post layout simulations. Relabel the ports
- check the layer they are present in by using ```what``` command over a port selected by ```select area``` command in tkcon window.  
- To remove port use - ```port remove``` command and to remove label use ```erase label``` command
- Then add label at the exact same location on the exact same layer, you may need to add a specific layers using ```paint``` or ```wire``` tools, where the port layer is not accessible.

![Screenshot from 2023-03-28 02-40-32](https://user-images.githubusercontent.com/50217106/228071735-33736dae-803e-4179-a4ed-2eb98acd1171.png)

After adding ports use    
 ```port makeall```   
Now extract the layout to obtain spice netlist
```
extract all
ext2spice cthresh 0 rthresh 0
ext2spice
```

### Post-Layout spice after adding pre-layout excitations and lib definitions
```
* SPICE3 file created from ADC_FLASH_0.ext - technology: sky130A
V1 VDD GND 1.8
.save i(v1)
V2 vin GND sin(0.9 0.9 50Meg)
.save i(v2)
V3 vref GND 0.9
.save i(v3)
x1 VDD out vin vref GND adc_flash
**** begin user architecture code

.tran 0.01n 100n
.save all


.param mc_mm_switch=0
.param mc_pr_switch=0
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/corners/tt.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/r+c/res_typical__cap_typical.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/r+c/res_typical__cap_typical__lin.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/corners/tt/specialized_cells.spice

**** end user architecture code
**.ends

* expanding   symbol:  /home/rahul/Documents/adcSingular/adc_flash.sym # of pins=5
** sym_path: /home/rahul/Documents/adcSingular/adc_flash.sym
** sch_path: /home/rahul/Documents/adcSingular/adc_flash.sch
.subckt adc_flash VDD out vin vref GND
X0 VDD VDD m1_1860_1484# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X1 m1_1860_1484# VDD VDD GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X2 VDD VDD m1_1860_1484# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X3 m1_1860_1484# VDD VDD GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X4 m1_656_1568# m1_656_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X5 VDD m1_656_1568# li_1953_2335# VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X6 VDD m1_656_1568# m1_656_1568# VDD sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X7 li_1953_2335# m1_656_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X8 m1_656_1568# m1_656_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X9 VDD m1_656_1568# m1_656_1568# VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X10 VDD m1_656_1568# li_1953_2335# VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X11 li_1953_2335# m1_656_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X12 m1_2322_1316# m1_1860_1484# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X13 m1_1860_1484# m1_1860_1484# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X14 GND m1_1860_1484# m1_2322_1316# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X15 GND m1_1860_1484# m1_1860_1484# GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X16 m1_2322_1316# m1_1860_1484# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X17 m1_1860_1484# m1_1860_1484# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X18 GND m1_1860_1484# m1_1860_1484# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X19 GND m1_1860_1484# m1_2322_1316# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X20 m1_516_1652# m1_1860_1484# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X21 GND m1_1860_1484# m1_516_1652# GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X22 m1_516_1652# m1_1860_1484# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X23 GND m1_1860_1484# m1_516_1652# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X24 VDD STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# OUT VDD sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X25 OUT STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X26 VDD STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# OUT VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X27 OUT STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X28 VDD m1_2322_1316# STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=3.99 pd=37 as=0.588 ps=5.32 w=1.05 l=0.15
X29 STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# m1_2322_1316# VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X30 VDD m1_2322_1316# STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X31 STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# m1_2322_1316# VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X32 OUT STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X33 GND STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# OUT GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X34 OUT STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X35 GND STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# OUT GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X36 STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# m1_2322_1316# GND GND sky130_fd_pr__nfet_01v8 ad=0.588 pd=5.32 as=3.99 ps=37 w=1.05 l=0.15
X37 GND m1_2322_1316# STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X38 STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# m1_2322_1316# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X39 GND m1_2322_1316# STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X40 m1_656_1568# VREF m1_516_1652# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X41 m1_516_1652# VREF m1_656_1568# GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X42 m1_656_1568# VREF m1_516_1652# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X43 m1_516_1652# VREF m1_656_1568# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X44 li_1953_2335# VIN m1_516_1652# GND sky130_fd_pr__nfet_01v8 ad=0.588 pd=5.32 as=2.289 ps=21.16 w=1.05 l=0.15
X45 m1_516_1652# VIN li_1953_2335# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X46 li_1953_2335# VIN m1_516_1652# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X47 m1_516_1652# VIN li_1953_2335# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X48 VDD li_1953_2335# m1_2322_1316# VDD sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X49 m1_2322_1316# li_1953_2335# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X50 VDD li_1953_2335# m1_2322_1316# VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X51 m1_2322_1316# li_1953_2335# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
C0 m1_2322_1316# VDD 4.01fF
C1 m1_516_1652# m1_1860_1484# 0.28fF
C2 VREF m1_516_1652# 0.16fF
C3 GND m1_516_1652# 0.19fF
C4 li_1953_2335# m1_516_1652# 1.68fF
C5 OUT VDD 1.63fF
C6 m1_2322_1316# m1_516_1652# 0.00fF
C7 STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# m1_1860_1484# 0.01fF
C8 GND STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# 0.55fF
C9 li_1953_2335# STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# 0.00fF
C10 VREF m1_1860_1484# 0.00fF
C11 GND m1_1860_1484# 1.07fF
C12 GND VREF 0.03fF
C13 VIN m1_656_1568# 0.01fF
C14 m1_2322_1316# STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# 0.84fF
C15 VIN VDD 0.01fF
C16 li_1953_2335# m1_1860_1484# 0.05fF
C17 li_1953_2335# VREF 0.31fF
C18 li_1953_2335# GND 0.34fF
C19 m1_2322_1316# m1_1860_1484# 0.90fF
C20 m1_2322_1316# VREF 0.00fF
C21 m1_2322_1316# GND 0.91fF
C22 OUT STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# 0.47fF
C23 m1_2322_1316# li_1953_2335# 0.26fF
C24 VIN m1_516_1652# 0.23fF
C25 OUT m1_1860_1484# 0.00fF
C26 OUT GND 0.04fF
C27 OUT li_1953_2335# 0.00fF
C28 m1_2322_1316# OUT 0.01fF
C29 VIN VREF 0.04fF
C30 VIN GND 0.01fF
C31 VIN li_1953_2335# 0.25fF
C32 m1_656_1568# VDD 5.13fF
C33 m1_656_1568# m1_516_1652# 1.63fF
C34 m1_516_1652# VDD 0.50fF
C35 STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# VDD 4.25fF
C36 m1_656_1568# m1_1860_1484# 0.04fF
C37 VREF m1_656_1568# 0.20fF
C38 GND m1_656_1568# 0.03fF
C39 VDD m1_1860_1484# 2.13fF
C40 VREF VDD 0.04fF
C41 GND VDD 1.11fF
C42 li_1953_2335# m1_656_1568# 0.98fF
C43 m1_2322_1316# m1_656_1568# 0.00fF
C44 li_1953_2335# VDD 3.76fF
C45 m1_516_1652# 0 1.39fF 
**FLOATING
C46 VDD 0 11.56fF 
**FLOATING
C47 VIN 0 1.07fF 
**FLOATING
C48 VREF 0 1.03fF 
**FLOATING
C49 m1_2322_1316# 0 1.78fF 
**FLOATING
C50 OUT 0 1.22fF 
**FLOATING
C51 STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# 0 1.36fF 
**FLOATING
C52 m1_1860_1484# 0 4.73fF 
**FLOATING
.ends

.GLOBAL VDD
.GLOBAL GND
.end

```

### Ngspice simulation output


![Screenshot from 2023-03-28 02-39-26](https://user-images.githubusercontent.com/50217106/228072557-6e6ed2ee-9e7d-4c95-b5de-e76eab6dc155.png)

Clearly, Pre-layout matches post-layout










## Verilog files required as input to the openFASOC flow for verilog generation
### Top level 
```verilog
module async4bituc(
 input VDD,
 input VSS,
 input vref,
 output out
 );
 wire inter1;
 
 onebitADC adc1(
 .VDD(VDD), .GND(VSS), .vin(inter1), .OUT(out), .VREF(vref)
 );
 
 ringosc osc1(
 .VDD(VDD), .GND(VSS), .OUT(inter1)
 );
 
endmodule
```
### ring oscillator
```verilog
module ringosc(
 input VDD,
 output OUT,
 input GND
 
);

endmodule
```
### 1-bit ADC
```verilog
module onebitADC(
 input VDD,
 input GND,
 input VIN,
 input VREF,
 output OUT
);


endmodule
```

-------------------------------------------------------------------------------


# RTL2GDS of the Analog design using openROAD( invoked by openFASOC)

With the necessary input files - gds of analog blocks and their dummy verilog we can proceed with the openFASOC flow to generate the complete analog block GDS.    
A directory - avsd4bituc, is created in the generators directory of openfasoc

![Screenshot from 2023-03-21 21-58-23](https://user-images.githubusercontent.com/50217106/226677270-e1751ed4-8883-4d6b-a6fb-809adadde9a7.png)

The necessary sub-directories for avsd4bituc are created.

![Screenshot from 2023-03-21 03-45-24](https://user-images.githubusercontent.com/50217106/226679150-da9f3152-0875-4fb8-bbee-5d908d267302.png)

The dummy verilog files are placed in the src directory

### contents of the test.json file
Include the frequency parameter in test.json file, and min and max frequency values are given according to the min max frequency vlaues defined in parameters.py script by default. In my case in parameters.py, by default min_freq is 5Mhz and max frequency is 12 Mhz. I went with the same frequencies for the design. 
![Screenshot from 2023-03-22 01-06-07](https://user-images.githubusercontent.com/50217106/226722166-5de39b89-33fc-45f6-bc59-4cae4412db85.png)

These values can be edited in parameters.py file in tools folder
![Screenshot from 2023-03-22 00-57-14(1)](https://user-images.githubusercontent.com/50217106/226736571-98ceff51-cee0-4311-9301-94821063f290.jpg)

The same frequency values are fed in modelfile.csv file present in tools directory.

![Screenshot from 2023-03-22 01-06-28](https://user-images.githubusercontent.com/50217106/226722335-17e836b1-a2d0-4903-a950-d385f0229edd.png)

### modifications in toplevel makefile - edit the commands that will be used for different purposes - verilog generation, rtl2gds etc.
![Screenshot from 2023-03-21 03-45-33](https://user-images.githubusercontent.com/50217106/226678613-44fdf5ba-1ee5-41a2-8268-d09fc99f936d.png)

#### avsd4bituc-gen.py, parameters.py and parse_rpt.py files in tools directory are modified as per generator directory structure

### The LEF and GDS of the auxilliary cells are placed in avsd4bituc/blocks/sky130hd - lef and gds folders respectively
To create LEF and GDS
- Import <design_name>.python.gds generated by Klayout
- Manually place the labels at repective locations. The make number of the port is the serial number of ports present in pre-layout spice netlist.
```label VDD```   
```port make 1```
- After placing the labels - ``` port makeall```
- Rename the cellname as the same you want to use in your OpenFASOC flow - ```cellname rename ADC_FLASH_0 onebitADC```
- Write GDS - ```gds write onebitADC.gds```
- write LEF - ```lef writeall```

### The config.mk file in design directory is modified -
1. DESIGN_NICKNAME is changed
2. DESIGN_NAME is changed
3. verilog file top-module name is changed
4. Additional GDS and LEF file names are changed
5. Custom connections are removed if any
6. Domain Instances are removed if any(since we do not need any additional voltage domain. Domain instances LIST will use a domain_instances.txt which should contain cells to be placed in that domain.
7. VD1 area is removed  represents the area that needs to be alloted to a smaller voltage domain)

---> Now a shell is opened in the avsd4bituc directory in generators and to generate verilog the corresponding code defined in top level makefile is used. In my case - "make sky130hd_auc_verilog"

![Screenshot from 2023-03-31 22-04-00](https://user-images.githubusercontent.com/50217106/229180452-ea9e3c96-57f2-494b-a7f7-9a5d1c967f1a.png)

To run the remaining steps - synthesis, placement, routing and finishing - we cd into flow directory and open a shell, then the following commands are used one by one -

```make synth```
![Screenshot from 2023-03-31 22-04-21](https://user-images.githubusercontent.com/50217106/229181137-ac6ecba6-3ce4-47aa-8467-acc02fd1043e.png)

```make floorplan```
![Screenshot from 2023-03-31 22-04-34](https://user-images.githubusercontent.com/50217106/229181225-b33eca80-c1dc-4b84-89ca-112a1d78d7b5.png)

```make gui_floorplan```
![Screenshot from 2023-03-31 22-04-58](https://user-images.githubusercontent.com/50217106/229181241-d6bd1db0-7449-46a1-9bc9-642689cca728.png)

```make place```

![Screenshot from 2023-03-31 22-01-01](https://user-images.githubusercontent.com/50217106/229186331-9519f640-2e87-4f05-93c4-81795fd40e0f.png)

![Screenshot from 2023-03-31 22-01-14](https://user-images.githubusercontent.com/50217106/229186364-98e58c76-9660-4bb9-b122-a19e8a5bfacb.png)

``` make gui_place```
Since the flow was placement of macros only, and there are no standard cells, floorplan and placement gui are same. It has been observed that floorplan stage uses the LEF while placement stage uses GDS. When origin co-ordinates in LEF and GDS are not matching, it leeds to displacement of cells in placement or floorplan stage.
![Screenshot from 2023-03-31 22-05-19](https://user-images.githubusercontent.com/50217106/229182180-8257f39e-6456-4e64-96a8-370c1863c41e.png)

```make route```
![Screenshot from 2023-03-31 22-00-08](https://user-images.githubusercontent.com/50217106/229186202-76fcd4d4-5646-450b-959d-a30c78d3b2f9.png)

![Screenshot from 2023-03-31 22-40-19](https://user-images.githubusercontent.com/50217106/229188630-ccb9a604-db5f-4412-b24d-d4a19d2ce907.png)

```make gui_route```

![Screenshot from 2023-03-31 22-05-47](https://user-images.githubusercontent.com/50217106/229182254-d3c42b31-0e48-4d19-a083-af7892edbd90.png)

```make finish```
![Screenshot from 2023-03-31 22-06-17](https://user-images.githubusercontent.com/50217106/229180168-9ef30443-ff05-4844-b66c-5ca4cfe24e83.png)
![Screenshot from 2023-03-31 22-06-11](https://user-images.githubusercontent.com/50217106/229180221-1da11235-1c82-469d-9b59-502b51adab3b.png)

The flow writes files genarated at individual steps in /avsd4bit-uc/flow/results

![Screenshot from 2023-03-31 22-06-37](https://user-images.githubusercontent.com/50217106/229180119-d6d6cc7d-e801-4c7c-89e8-9e8f9276e541.png)

## Final Layout viewed in KLAYOUT

![Screenshot from 2023-03-31 21-55-58](https://user-images.githubusercontent.com/50217106/229185031-87969e08-c276-4ee2-94fb-facd609ed103.png)


![Screenshot from 2023-03-31 22-39-02](https://user-images.githubusercontent.com/50217106/229185615-cda9b045-0a88-40f3-998d-4fb298552ad2.png)

To check if design is DRC clean, ```make clean_all``` in flow directory and come to the generators folder and as per your makefile, use the make command that does complete verilog generation, RTL-GDS and physical verification. In my case - make sky130_auc_full

![Screenshot from 2023-03-31 21-58-15](https://user-images.githubusercontent.com/50217106/229184959-5891ce57-e7be-405a-a290-1a5df15f5d26.png)






Design is DRC clean for
DIE_AREA =  0 0 100 100
CORE_AREA = 10 10 90 90

-------------------------------------------------------------------


## Design - In memory logic Operations using 8T-SRAM cells


8TSRAM cells are written with values either 0 or 1. The value stored is then fed to the read circuitry of 8TSRAM cells(Gate of the nfets) The RBL(Read Bit line) capacitor is precharged. Both 8TSRAM cells are written with 0 or 1, which is equivalent to providing input to a logic GATE. After the values are written, a read bit line enable mosfet switches on. This happens together with a read word line being enabled. This allows the precharged capacitor to discharge via any of the two nfets if their gate potential is high( gate potential high means that 8TSRAM cell has logic 1 written to it). This makes the precahrged capacitor potential mimic a logic value corresponding to a NOR operation. This NOR output from capacitor is input to a CMOS inverter to generate an OR operation. The verilog code of MUX gets input Data[1:0]. When Sel(select line) is 1 the output from the analog port generating logic operation OR is chosen. When Sel is 0 the output from the analog port generating NOR is chosen.


![image](https://user-images.githubusercontent.com/50217106/232707806-afce17c3-e3ae-4f3d-a97a-a638a79ba1fb.png)

![image](https://user-images.githubusercontent.com/50217106/232707976-989f9375-b24f-481d-9888-b9e408c57bb1.png)


![image](https://user-images.githubusercontent.com/50217106/232708046-ea6f0d65-6657-4bca-a33d-ac6ceb79bab9.png)

## pre-layout analysis
Design in Xschem

![Screenshot from 2023-04-16 00-41-30](https://user-images.githubusercontent.com/50217106/232278766-f15ea202-18b1-46bc-b0e5-67cea7ef1f21.png)

![Screenshot from 2023-04-16 00-41-39](https://user-images.githubusercontent.com/50217106/232278796-e2fbf48b-74a2-483c-adac-5765fbe0582d.png)

The read operation happens when RWL is enabled(in my design it's enabled when it goes high).

OR and NOR operation with 0 written to both 8TSRAM cells

![Screenshot from 2023-04-18 12-58-23](https://user-images.githubusercontent.com/50217106/232706520-883406c0-8a0a-4109-b85b-ea412b6a5474.png)

OR and NOR operation with 0 written to one and 1 written to another SRAM cell

![Screenshot from 2023-04-18 12-59-41](https://user-images.githubusercontent.com/50217106/232706626-8f82a35d-60f3-455f-9702-28d707a9e523.png)

OR and NOR operation with 1 written to both SRAM cells

![Screenshot from 2023-04-18 13-00-55](https://user-images.githubusercontent.com/50217106/232706288-3bb588fc-b196-42cc-b716-842e72b9a938.png)

<details>
<summary>PRE-LAYOUT SPICE </summary>
<br>

```
** sch_path: /home/rahul/Documents/sramlogic/sramcomp.sch
.subckt sramcomp Q1 Q2 NOR OR WWL WBLB1 WBL2 WBL1 WBLB2 RWL RBLprechargeEnable RBLprecharge WWL WBL1
+ WBLB1 RWL RBLprechargeEnable RBLprecharge WBL2 WBLB2
*.PININFO Q1:O Q2:O NOR:O OR:O WWL:I WBLB1:I WBL2:I WBL1:I WBLB2:I RWL:I RBLprechargeEnable:I
*+ RBLprecharge:I WWL:I WBL1:I WBLB1:I RWL:I RBLprechargeEnable:I RBLprecharge:I WBL2:I WBLB2:I
x1 WWL VDD WBLB1 WBL2 WBL1 WBLB2 GND Q1 Q2 RWL RBLprechargeEnable RBLprecharge NOR OR sramlogic
V1 VDD GND 1.8
.save i(v1)
V2 WWL GND pulse(0 1.8 10n 5n 5n 10n 50n)
.save i(v2)
V3 WBL1 GND pulse(1.8 0 0 5n 5n 20n 50n)
.save i(v3)
V4 WBL2 GND pulse(1.8 0 0 5n 5n 20n 50n)
.save i(v4)
V5 RBLprecharge GND pulse(0 1.8 0 5n 5n 15n 50n)
.save i(v5)
V6 RWL GND pulse(0 1.8 30n 5n 5n 10n 50n)
.save i(v6)
V7 WBLB1 GND pulse(0 1.8 0 5n 5n 20n 50n)
.save i(v7)
V8 WBLB2 GND pulse(0 1.8 0 5n 5n 20n 50n)
.save i(v8)
V9 RBLprechargeEnable GND pulse(1.8 0 5n 5n 5n 5n 50n)
.save i(v9)
**** begin user architecture code

.tran 0.01n 50n
.save all


.param mc_mm_switch=0
.param mc_pr_switch=0
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/corners/tt.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/r+c/res_typical__cap_typical.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/r+c/res_typical__cap_typical__lin.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/corners/tt/specialized_cells.spice

**** end user architecture code
.ends

* expanding   symbol:  /home/rahul/Documents/sramlogic/sramlogic.sym # of pins=14
** sym_path: /home/rahul/Documents/sramlogic/sramlogic.sym
** sch_path: /home/rahul/Documents/sramlogic/sramlogic.sch
.subckt sramlogic WWL VDD WBLB1 WBL2 WBL1 WBLB2 GND Q1 Q2 RWL RBLprechargeEnable RBLprecharge NOR OR
*.PININFO WWL:I VDD:B GND:B WBL1:I WBL2:I WBLB2:I WBLB1:I Q1:O Q2:O RWL:I RBLprecharge:I NOR:O
*+ RBLprechargeEnable:I OR:O
XM1 net1 Q1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=2 nf=1 m=1
XM3 net1 Q1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM2 Q1 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM4 Q1 net1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=2 nf=1 m=1
XM5 net2 Q2 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=2 nf=1 m=1
XM6 net2 Q2 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM7 Q2 net2 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 m=1
XM8 Q2 net2 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=2 nf=1 m=1
XM9 WBL1 WWL Q1 GND sky130_fd_pr__nfet_01v8 L=0.15 W=2 nf=1 m=1
XM10 net1 WWL WBLB1 GND sky130_fd_pr__nfet_01v8 L=0.15 W=2 nf=1 m=1
XM11 WBL2 WWL Q2 GND sky130_fd_pr__nfet_01v8 L=0.15 W=2 nf=1 m=1
XM12 net2 WWL WBLB2 GND sky130_fd_pr__nfet_01v8 L=0.15 W=2 nf=1 m=1
XM13 net3 Q1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM14 net4 Q2 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM15 net5 RWL net3 GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM16 net5 RWL net4 GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM18 net6 net5 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=2 nf=1 m=1
XM19 net6 net5 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM20 NOR net6 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=2 nf=1 m=1
XM21 NOR net6 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
XM17 net5 RBLprechargeEnable RBLprecharge VDD sky130_fd_pr__pfet_01v8 L=0.15 W=2 nf=1 m=1
XM22 OR net5 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=2 nf=1 m=1
XM23 OR net5 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 m=1
.ends

.GLOBAL GND
.GLOBAL VDD
.end
```
</details>


## .sp fed to ALIGN
```
.subckt sramlogic WWL VDD WBLB1 WBL2 WBL1 WBLB2 GND Q1 Q2 RWL RBLprechargeEnable RBLprecharge NOR OR
XM1 net1 Q1 GND GND sky130_fd_pr__nfet_01v8 L=150n W=840n nf=2
XM3 net1 Q1 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=420n nf=2
XM2 Q1 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=420n nf=2
XM4 Q1 net1 GND GND sky130_fd_pr__nfet_01v8 L=150n W=840n nf=2
XM5 net2 Q2 GND GND sky130_fd_pr__nfet_01v8 L=150n W=840n nf=2
XM6 net2 Q2 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=420n nf=2
XM7 Q2 net2 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=420n nf=2
XM8 Q2 net2 GND GND sky130_fd_pr__nfet_01v8 L=150n W=840n nf=2
XM9 WBL1 WWL Q1 GND sky130_fd_pr__nfet_01v8 L=150n W=840n nf=2
XM10 net1 WWL WBLB1 GND sky130_fd_pr__nfet_01v8 L=150n W=840n nf=2
XM11 WBL2 WWL Q2 GND sky130_fd_pr__nfet_01v8 L=150n W=840n nf=2
XM12 net2 WWL WBLB2 GND sky130_fd_pr__nfet_01v8 L=150n W=840n nf=2
XM13 net3 Q1 GND GND sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
XM14 net4 Q2 GND GND sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
XM15 net5 RWL net3 GND sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
XM16 net5 RWL net4 GND sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
XM18 net6 net5 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=840n nf=2
XM19 net6 net5 GND GND sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
XM20 NOR net6 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=840n nf=2
XM21 NOR net6 GND GND sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
XM17 net5 RBLprechargeEnable RBLprecharge VDD sky130_fd_pr__pfet_01v8 L=150n W=840n nf=2
XM22 OR net5 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=840n nf=2
XM23 OR net5 GND GND sky130_fd_pr__nfet_01v8 L=150n W=420n nf=2
.ends
```

In the ~/ALIGN-public/work directory use the following command - 
```schematic2layout ../examples/sramlogic -p ../pdks/SKY130PDK/```
![Screenshot from 2023-04-16 12-10-38](https://user-images.githubusercontent.com/50217106/232277674-ea0cd2e0-5f61-4f1a-bd06-52237994b444.png)
![Screenshot from 2023-04-16 12-10-29](https://user-images.githubusercontent.com/50217106/232277691-29dddf65-bb15-44ab-a3ef-5ba300dcc021.png)

![Screenshot from 2023-04-15 22-24-10](https://user-images.githubusercontent.com/50217106/232278155-f55324d2-a5f7-4161-8bf0-e2a2e5017e01.png)

## Post-Layout Simulations
ALIGN generated layout is read in magic
After the gds is read, we remove all the ports using ```port remove``` and ```erase label```
Then at those port locations, we drop the ports in the exact layer. Save the gds
![Screenshot from 2023-04-16 11-54-01](https://user-images.githubusercontent.com/50217106/232277097-cd15bbe5-0413-4753-a127-381822d263cd.png)

```
port makeall
extract all
ext2spice cthresh 0 rthresh 0
ext2spice
```
<details>
<summary>POST-LAYOUT SPICE</summary>
<br>

	
Magic tool writes out the post-layout spice netlist, which needs the pre-layout excitations and library definitions
```
* SPICE3 file created from SRAMLOGIC_0.ext - technology: sky130A

x1 WWL VDD WBLB1 WBL2 WBL1 WBLB2 GND Q1 Q2 RWL RBLprechargeEnable RBLprecharge NOR OR sramlogic
V1 VDD GND 1.8
.save i(v1)
V2 WWL GND pulse(0 1.8 10n 5n 5n 10n 50n)
.save i(v2)
V3 WBL1 GND pulse(0 1.8 0 5n 5n 20n 50n)
.save i(v3)
V4 WBL2 GND pulse(0 1.8 0 5n 5n 20n 50n)
.save i(v4)
V5 RBLprecharge GND pulse(0 1.8 0 5n 5n 15n 50n)
.save i(v5)
V6 RWL GND pulse(0 1.8 30n 5n 5n 10n 50n)
.save i(v6)
V7 WBLB1 GND pulse(1.8 0 0 5n 5n 20n 50n)
.save i(v7)
V8 WBLB2 GND pulse(1.8 0 0 5n 5n 20n 50n)
.save i(v8)
V9 RBLprechargeEnable GND pulse(1.8 0 5n 5n 5n 5n 50n)
.save i(v9)
**** begin user architecture code

.tran 0.01n 50n
.save all


.param mc_mm_switch=0
.param mc_pr_switch=0
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/corners/tt.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/r+c/res_typical__cap_typical.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/r+c/res_typical__cap_typical__lin.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/corners/tt/specialized_cells.spice


.subckt sramlogic WWL VDD WBLB1 WBL2 WBL1 WBLB2 GND Q1 Q2 RWL RBLprechargeEnable RBLprecharge NOR OR
X0 m1_774_5096# Q2 GND GND sky130_fd_pr__nfet_01v8 ad=0.1176 pd=1.12 as=0.2226 ps=2.21 w=0.84 l=0.15
X1 GND Q2 m1_774_5096# GND sky130_fd_pr__nfet_01v8 ad=0.2226 pd=2.21 as=0.1176 ps=1.12 w=0.84 l=0.15
X2 m1_774_5096# Q2 VDD VDD sky130_fd_pr__pfet_01v8 ad=0.0588 pd=0.7 as=0.1113 ps=1.37 w=0.42 l=0.15
X3 VDD Q2 m1_774_5096# VDD sky130_fd_pr__pfet_01v8 ad=0.1113 pd=1.37 as=0.0588 ps=0.7 w=0.42 l=0.15
X4 Q2 m1_774_5096# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.0588 pd=0.7 as=0.1113 ps=1.37 w=0.42 l=0.15
X5 VDD m1_774_5096# Q2 VDD sky130_fd_pr__pfet_01v8 ad=0.1113 pd=1.37 as=0.0588 ps=0.7 w=0.42 l=0.15
X6 Q2 m1_774_5096# GND GND sky130_fd_pr__nfet_01v8 ad=0.1176 pd=1.12 as=0.2226 ps=2.21 w=0.84 l=0.15
X7 GND m1_774_5096# Q2 GND sky130_fd_pr__nfet_01v8 ad=0.2226 pd=2.21 as=0.1176 ps=1.12 w=0.84 l=0.15
X8 OR li_749_2436# GND GND sky130_fd_pr__nfet_01v8 ad=0.0588 pd=0.7 as=0.1113 ps=1.37 w=0.42 l=0.15
X9 GND li_749_2436# OR GND sky130_fd_pr__nfet_01v8 ad=0.1113 pd=1.37 as=0.0588 ps=0.7 w=0.42 l=0.15
X10 OR li_749_2436# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.1176 pd=1.12 as=0.2226 ps=2.21 w=0.84 l=0.15
X11 VDD li_749_2436# OR VDD sky130_fd_pr__pfet_01v8 ad=0.2226 pd=2.21 as=0.1176 ps=1.12 w=0.84 l=0.15
X12 WBL1 WWL Q1 GND sky130_fd_pr__nfet_01v8 ad=0.1176 pd=1.12 as=0.2226 ps=2.21 w=0.84 l=0.15
X13 Q1 WWL WBL1 GND sky130_fd_pr__nfet_01v8 ad=0.2226 pd=2.21 as=0.1176 ps=1.12 w=0.84 l=0.15
X14 WBL2 WWL Q2 GND sky130_fd_pr__nfet_01v8 ad=0.1176 pd=1.12 as=0.2226 ps=2.21 w=0.84 l=0.15
X15 Q2 WWL WBL2 GND sky130_fd_pr__nfet_01v8 ad=0.2226 pd=2.21 as=0.1176 ps=1.12 w=0.84 l=0.15
X16 NOR STAGE2_INV_31433453_0_0_1681577487_0/li_491_571# GND GND sky130_fd_pr__nfet_01v8 ad=0.0588 pd=0.7 as=0.1113 ps=1.37 w=0.42 l=0.15
X17 GND STAGE2_INV_31433453_0_0_1681577487_0/li_491_571# NOR GND sky130_fd_pr__nfet_01v8 ad=0.1113 pd=1.37 as=0.0588 ps=0.7 w=0.42 l=0.15
X18 STAGE2_INV_31433453_0_0_1681577487_0/li_491_571# li_749_2436# GND GND sky130_fd_pr__nfet_01v8 ad=0.1176 pd=1.4 as=2.7888 ps=30.04 w=0.42 l=0.15
X19 GND li_749_2436# STAGE2_INV_31433453_0_0_1681577487_0/li_491_571# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.42 l=0.15
X20 NOR STAGE2_INV_31433453_0_0_1681577487_0/li_491_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.1176 pd=1.12 as=0.2226 ps=2.21 w=0.84 l=0.15
X21 VDD STAGE2_INV_31433453_0_0_1681577487_0/li_491_571# NOR VDD sky130_fd_pr__pfet_01v8 ad=0.2226 pd=2.21 as=0.1176 ps=1.12 w=0.84 l=0.15
X22 STAGE2_INV_31433453_0_0_1681577487_0/li_491_571# li_749_2436# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.2352 pd=2.24 as=2.226 ps=24.22 w=0.84 l=0.15
X23 VDD li_749_2436# STAGE2_INV_31433453_0_0_1681577487_0/li_491_571# VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.84 l=0.15
X24 m1_774_5096# WWL WBLB2 GND sky130_fd_pr__nfet_01v8 ad=0.4704 pd=4.48 as=0.4452 ps=4.42 w=0.84 l=0.15
X25 WBLB2 WWL m1_774_5096# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.84 l=0.15
X26 m1_946_6860# WWL WBLB1 GND sky130_fd_pr__nfet_01v8 ad=0.4704 pd=4.48 as=0.4452 ps=4.42 w=0.84 l=0.15
X27 WBLB1 WWL m1_946_6860# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.84 l=0.15
X28 m1_1548_3164# Q2 GND GND sky130_fd_pr__nfet_01v8 ad=0.0588 pd=0.7 as=0.0588 ps=0.7 w=0.42 l=0.15
X29 GND Q2 m1_1548_3164# GND sky130_fd_pr__nfet_01v8 ad=0.1113 pd=1.37 as=0.0588 ps=0.7 w=0.42 l=0.15
X30 li_2297_3091# Q1 GND GND sky130_fd_pr__nfet_01v8 ad=0.0588 pd=0.7 as=0.1113 ps=1.37 w=0.42 l=0.15
X31 GND Q1 li_2297_3091# GND sky130_fd_pr__nfet_01v8 ad=0.0588 pd=0.7 as=0.0588 ps=0.7 w=0.42 l=0.15
X32 m1_946_6860# Q1 GND GND sky130_fd_pr__nfet_01v8 ad=0.1176 pd=1.12 as=0.2226 ps=2.21 w=0.84 l=0.15
X33 GND Q1 m1_946_6860# GND sky130_fd_pr__nfet_01v8 ad=0.2226 pd=2.21 as=0.1176 ps=1.12 w=0.84 l=0.15
X34 m1_946_6860# Q1 VDD VDD sky130_fd_pr__pfet_01v8 ad=0.0588 pd=0.7 as=0.1113 ps=1.37 w=0.42 l=0.15
X35 VDD Q1 m1_946_6860# VDD sky130_fd_pr__pfet_01v8 ad=0.1113 pd=1.37 as=0.0588 ps=0.7 w=0.42 l=0.15
X36 Q1 m1_946_6860# GND GND sky130_fd_pr__nfet_01v8 ad=0.1176 pd=1.12 as=0.2226 ps=2.21 w=0.84 l=0.15
X37 GND m1_946_6860# Q1 GND sky130_fd_pr__nfet_01v8 ad=0.2226 pd=2.21 as=0.1176 ps=1.12 w=0.84 l=0.15
X38 Q1 m1_946_6860# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.0588 pd=0.7 as=0.1113 ps=1.37 w=0.42 l=0.15
X39 VDD m1_946_6860# Q1 VDD sky130_fd_pr__pfet_01v8 ad=0.1113 pd=1.37 as=0.0588 ps=0.7 w=0.42 l=0.15
X40 li_749_2436# RBLprechargeEnable RBLprecharge VDD sky130_fd_pr__pfet_01v8 ad=0.1176 pd=1.12 as=0.2226 ps=2.21 w=0.84 l=0.15
X41 RBLprecharge RBLprechargeEnable li_749_2436# VDD sky130_fd_pr__pfet_01v8 ad=0.2226 pd=2.21 as=0.1176 ps=1.12 w=0.84 l=0.15
X42 li_749_2436# RWL m1_1548_3164# GND sky130_fd_pr__nfet_01v8 ad=0.0588 pd=0.7 as=0.1113 ps=1.37 w=0.42 l=0.15
X43 m1_1548_3164# RWL li_749_2436# GND sky130_fd_pr__nfet_01v8 ad=0.1113 pd=1.37 as=0.0588 ps=0.7 w=0.42 l=0.15
X44 li_749_2436# RWL li_2297_3091# GND sky130_fd_pr__nfet_01v8 ad=0.2352 pd=2.8 as=0.3402 ps=4.14 w=0.42 l=0.15
X45 li_2297_3091# RWL li_749_2436# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=0.42 l=0.15
C0 Q2 Q1 0.35fF
C1 STAGE2_INV_31433453_0_0_1681577487_0/li_491_571# VDD 3.25fF
C2 Q1 RWL 0.29fF
C3 li_2297_3091# Q2 0.00fF
C4 Q1 VDD 2.92fF
C5 NOR VDD 0.87fF
C6 Q1 WWL 0.13fF
C7 li_2297_3091# RWL 0.15fF
C8 li_749_2436# OR 0.41fF
C9 Q2 WBL1 0.00fF
C10 STAGE2_INV_31433453_0_0_1681577487_0/li_491_571# RBLprecharge 0.00fF
C11 WBLB2 WBL2 0.00fF
C12 li_2297_3091# VDD 0.01fF
C13 RBLprechargeEnable VDD 0.74fF
C14 m1_774_5096# WBL2 0.00fF
C15 Q2 WBL2 0.62fF
C16 NOR RBLprecharge 0.00fF
C17 VDD WBL1 0.00fF
C18 WBLB1 m1_946_6860# 0.57fF
C19 m1_1548_3164# STAGE2_INV_31433453_0_0_1681577487_0/li_491_571# 0.01fF
C20 Q2 li_749_2436# 0.03fF
C21 WWL WBL1 0.14fF
C22 m1_774_5096# WBLB2 0.66fF
C23 WBL2 VDD 0.00fF
C24 RBLprechargeEnable RBLprecharge 0.11fF
C25 li_749_2436# RWL 0.23fF
C26 Q2 WBLB2 0.00fF
C27 m1_1548_3164# Q1 0.01fF
C28 WWL WBL2 0.12fF
C29 m1_1548_3164# NOR 0.00fF
C30 VDD OR 0.95fF
C31 li_749_2436# VDD 3.93fF
C32 Q2 m1_774_5096# 0.84fF
C33 Q1 m1_946_6860# 1.18fF
C34 m1_1548_3164# li_2297_3091# 0.08fF
C35 m1_774_5096# RWL 0.00fF
C36 Q2 RWL 0.51fF
C37 Q1 WBLB1 0.01fF
C38 WWL WBLB2 0.13fF
C39 m1_774_5096# VDD 2.30fF
C40 Q2 VDD 2.45fF
C41 WWL m1_774_5096# 0.17fF
C42 RBLprecharge OR 0.00fF
C43 li_749_2436# RBLprecharge 0.76fF
C44 STAGE2_INV_31433453_0_0_1681577487_0/li_491_571# NOR 0.26fF
C45 Q2 WWL 0.54fF
C46 WBL1 m1_946_6860# 0.00fF
C47 RWL VDD 0.07fF
C48 li_2297_3091# STAGE2_INV_31433453_0_0_1681577487_0/li_491_571# 0.00fF
C49 STAGE2_INV_31433453_0_0_1681577487_0/li_491_571# RBLprechargeEnable 0.04fF
C50 WBL2 m1_946_6860# 0.02fF
C51 m1_1548_3164# li_749_2436# 0.74fF
C52 li_2297_3091# Q1 0.13fF
C53 WBL2 WBLB1 0.00fF
C54 m1_1548_3164# m1_774_5096# 0.00fF
C55 RBLprecharge VDD 0.36fF
C56 WBLB2 m1_946_6860# 0.00fF
C57 m1_1548_3164# Q2 0.13fF
C58 Q1 WBL1 0.64fF
C59 m1_774_5096# m1_946_6860# 0.66fF
C60 STAGE2_INV_31433453_0_0_1681577487_0/li_491_571# OR 0.00fF
C61 STAGE2_INV_31433453_0_0_1681577487_0/li_491_571# li_749_2436# 1.10fF
C62 Q2 m1_946_6860# 0.18fF
C63 m1_1548_3164# RWL 0.15fF
C64 WBLB2 WBLB1 0.04fF
C65 Q1 WBL2 0.00fF
C66 m1_774_5096# WBLB1 0.18fF
C67 m1_1548_3164# VDD 0.02fF
C68 RWL m1_946_6860# 0.00fF
C69 Q2 WBLB1 0.11fF
C70 li_749_2436# Q1 0.00fF
C71 NOR OR 0.02fF
C72 li_749_2436# NOR 0.36fF
C73 VDD m1_946_6860# 2.65fF
C74 Q2 STAGE2_INV_31433453_0_0_1681577487_0/li_491_571# 0.00fF
C75 WWL m1_946_6860# 0.12fF
C76 li_2297_3091# li_749_2436# 0.83fF
C77 li_749_2436# RBLprechargeEnable 0.17fF
C78 STAGE2_INV_31433453_0_0_1681577487_0/li_491_571# RWL 0.00fF
C79 Q1 m1_774_5096# 0.00fF
C80 WBL2 WBL1 0.00fF
C81 WWL WBLB1 0.13fF
C82 WWL GND 3.33fF
C83 VDD GND 19.11fF
C84 RWL GND 2.09fF
C85 m1_946_6860# GND 0.96fF 
**FLOATING
C86 m1_1548_3164# GND 1.12fF 
**FLOATING
C87 li_2297_3091# GND 0.79fF 
**FLOATING
C88 Q1 GND 3.05fF
C89 WBLB2 GND 0.36fF
C90 WBLB1 GND 0.30fF
C91 STAGE2_INV_31433453_0_0_1681577487_0/li_491_571# GND 0.87fF 
**FLOATING
C92 NOR GND 0.58fF
C93 WBL1 GND 0.07fF
C94 WBL2 GND 0.16fF
C95 OR GND 0.56fF
C96 li_749_2436# GND 0.89fF 
**FLOATING
C97 m1_774_5096# GND 1.52fF 
**FLOATING
C98 Q2 GND 4.41fF
.ends


.GLOBAL VDD
.GLOBAL GND

.end

```
</details>




To perform spice simulations, in the same direactory - ```ngspice SRAMLOGIC_0.spice```

![Screenshot from 2023-04-16 00-29-52](https://user-images.githubusercontent.com/50217106/232278070-799a51f9-a6e0-4c4f-b8f6-9e5d962f0c11.png)

![Screenshot from 2023-04-16 00-26-38](https://user-images.githubusercontent.com/50217106/232278075-28991164-5ac0-4165-9e6b-206b6f7254fe.png)

When RWL gets enabled the logic operation begins. To write into the SRAM cells, a WWL signal is used. These two signals have different ON times to make the read and write operation occur exclusive to each other.
When the sram bit cells are written with bits 0 both, logic operation NOR gives out a 1 and logic operation OR gives out  a 0
![Screenshot from 2023-04-16 00-26-38](https://user-images.githubusercontent.com/50217106/232278343-156e55fb-cfa0-4b38-860d-8bc63ccf60ba.png)

When the SRAM bit cells are both written with 1, NOR operation should give a 0 and OR should give a 1, which is the required output.

![Screenshot from 2023-04-16 01-21-30](https://user-images.githubusercontent.com/50217106/232278705-7f7df604-1e14-4356-b498-107b639231d8.png)

Clearly post-layout results are similar to pre-layout

## OpenFASOC FLOW for MIXED SIGNAL BLOCK
Our mixed signal block comprises of an analog block which is the 8TSRAM cells and read circuitry that performs NOR and OR, and the digital block comprises of a 2*1 MUX which selects one of the two logics depending on a select line input. 
Openfasoc treats the analog part of mixed signal block as a macro and places it on the core as per placement commands in manual_macro.tcl. For macros operating on differrent operating voltages different voltage domains can be created with commands in pdn.tcl. We need to provide GDS and LEF view of the macro to openfasoc. Macro is placed during the floorplanning stage of physical design flow
Standard cells are used for the digital components and they are placed during placement stage in the openroad physical design flow.
The mixed signal block's dummy verilog is written - a blackbox representation - verilog with pins for analog macros and corresponding synthesizable verilog for digital blocks.

### Verilog for MIXED SIGNAL BLOCK

```verilog
module imc(  
	input WBL1, 
	input WBLB1, 
	input WBL2, 
	input WBLB2, 
	input RWL, 
	input WWL, 
	input SEL, 
	input RBLprecharge, 
	input RBLprechargeEnable,
	output out, Q1, Q2
);
wire inter1;
wire inter2;

SRAMLOGIC sramlogic(.WBL1(WBL1), .WBLB1(WBLB1), .WBL2(WBL2), .WBLB2(WBLB2), .OR(inter1), .NOR(inter2), .Q1(Q1), .Q2(Q2), 
	.RBLprechargeEnable(RBLprechargeEnable), .RBLprecharge(RBLprecharge), .RWL(RWL), .WWL(WWL)
);

MUX2_1 mux(.in1(inter1), .in2(inter2), .out(out), .sel(SEL)
);

endmodule

```

```verilog

module SRAMLOGIC(
		input WWL,
		input RWL,
		input WBL1,
		input WBLB1,
		input WBL2,
		input WBLB2,
		input RBLprecharge,
		input RBLprechargeEnable,
		output Q1, 
		output Q2,
		output NOR,
		output OR
	);
endmodule

```

```verilog 

module MUX2_1(
       	input in1, 
	input in2, 
	input sel,
	output out
);

assign out = sel?in2:in1;

endmodule
```

In our design,  The digital block 2_1 MUX will be placed as a standard cell in the design during the placement stage of the OpenFASOC flow, while the analog block will be treated as a macro and placed during the floorplan stage.

In the directory of the generator IMC-gen - to perform all the steps required for openfasoc flow - verilog generation, RTL2GDS, physical verification, the following make utility is placed and the make command is run
```export PDK_ROOT=/home/rahul/open_pdks/sky130/```
```make sky130hd_imc_full```
The FLow completes with 0 DRCs

<details>
<summary>OpenFASOC flow on IMC</summary>
<br>
Refer to the flow.txt file
</details>

The GDS will have DRCs if 
- The origin of GDS and LEF is not 0,0. Not having origin as 0,0 causes another problem where the pins of mixed signal block might be missing the macro ports
- Position of macros are such that the placement and routing algorithms might nor find a solution that places macros, power straos and cells like decaps, tapcells etc. without DRCs
- To get rid of DRCs, adjust the position of macro in the manual_macro.tcl file or bring the LEF,GDS to origin in magic tool

### magic view - ```magic -D XR sky130A.tech```  and then read GDS
![Screenshot from 2023-05-24 21-27-49](https://github.com/rahulearn2019/msvsdpim/assets/50217106/3fe93ddb-df2e-44f7-920b-a4734079c87d)

### klayout view
![Screenshot from 2023-05-24 20-55-28](https://github.com/rahulearn2019/msvsdpim/assets/50217106/f5fc6522-e715-46f3-b9e7-a7c7ae6109a3)
To route the VDD and GND power nets to the macro VDD and GND pins, pre-global-route.tcl file is edited, pdn.tcl is edited, and two files VSS_CONNECTION.txt and VDD_CONNECTION.txt are added, and their paths are added in config.mk
Note the VDD and GND connections of macro's VDD and GND pins to VDD and GND power straps in magic
![Screenshot from 2023-05-24 21-27-33](https://github.com/rahulearn2019/msvsdpim/assets/50217106/d71633ce-f81b-448e-a35a-4293eb0c708a)
![Screenshot from 2023-05-24 21-22-40](https://github.com/rahulearn2019/msvsdpim/assets/50217106/e7a20073-7659-4123-b112-a0eb66fef8e5)
You might face a signal11 error, which stops the automated RTL2GDS flow right before routing. To get rid of this error, I kept the core dimensions by less than 30 units from the die dimensions.

After the flow completes you can read the GDS again and observe macro VDD and GND pins being connected to VDD and GND power straps in magic, The GDS is extracted and spice netlist is obtained.
The GDS after extraction needs spice models of cells like tapcells, decaps, fill cells. 


## References
- https://openfasoc.readthedocs.io/en/latest/flow-tempsense.html
- https://www.sciencedirect.com/science/article/abs/pii/S002627142100411X
- https://openroad-flow-scripts.readthedocs.io/en/latest/
- [1] Amogh Agrawal, Akhilesh Jaisawal, Chankyu Lee and Kaushik Roy, “X-SRAM: Enabling In-memory Boolean Computations in CMOS Static Random Access Memories”. Circuits and Systems I: Regular Papers, IEEE Transactions on PP(99), December 2017 [2] Sparsh Mittal, Gaurav Verma, Brajesh Kaushik, Farooq A. Khanday, “A Survey of SRAM-based Processing-in-Memory Techniques and Applications”. Journal of Systems Architecture, Volume 119, October 2021, 102276

## Acknowledgements
- Kunal Ghosh, Founder VLSI System Design, Mtech IIT Bombay - https://www.vlsisystemdesign.com/
- Sumanto Kar, Research Associate, IIT Bombay
