# msvsdpim
## week0
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

![Screenshot from 2023-02-10 09-59-06](https://user-images.githubusercontent.com/50217106/218091959-d2df3d36-6d16-44cd-bf57-a6d660c0e5f7.png)

### Inverter DC analysis
![Screenshot from 2023-02-09 14-25-28](https://user-images.githubusercontent.com/50217106/218139861-b6a31207-693a-44c2-92c8-487d8d567a62.png)
![Screenshot from 2023-02-09 14-25-22](https://user-images.githubusercontent.com/50217106/218139881-58da4097-beca-4045-a07e-d97ca350870f.png)



![Screenshot from 2023-02-09 14-25-11](https://user-images.githubusercontent.com/50217106/218139230-5c07698e-fdc8-4ec4-9fe6-370c84e85f2b.png)


### Creating and Simulating testbench Schematic

![Screenshot from 2023-02-10 10-06-28](https://user-images.githubusercontent.com/50217106/218089214-f6946c50-e88c-4d48-8a03-eaa9b9768587.png)

### Calculation of Pre-layout Inverter delay using ngspice and plots
![Screenshot from 2023-02-10 10-06-10](https://user-images.githubusercontent.com/50217106/218088836-ed10f081-b9f8-402e-b847-555a27e54b63.png)

clicking on the Vin and Vout curves give coordinates on the ngspice terminal

![Screenshot from 2023-02-10 10-06-28](https://user-images.githubusercontent.com/50217106/218089214-f6946c50-e88c-4d48-8a03-eaa9b9768587.png)

the difference in corrdinates give the pre-layout inverer delay values
delay = 1.3ps

Multiple iterations of simulations is performed and an average delay value is finalised.

## Creation of Layout using inverter schematic in layout tool MAGIC
Create a working directory with sky130A.tech, .xschemrc and .sky130magicrc files or you can import these files to the MAGIC directory itself. Either way open the working directory and use the following command
```
'MAGIC -T sky130A.tech
```
This opens up the tkcon and layout windows


In the Layout window import the spice netlist of your inverter(one which has pins and fets, and is the bottomost hierarchy of the inverter testbench)
The metal input and output pins are imported and the nfet and pfet is imported
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


We right click and stretch on the plots vin and vout. A new expkanded vin vs vout is generated. We expand until the vin and vout pulses are far apart. 
When we expand at the 50% rise points(approximately selected), and click on the two plots, the x coordinate(time) and y coordinate(voltage) appears on ngspice. If we subtract them we get the required delay(post-layout).

Post Layout Delay 1.0551 - 1.02765 = 0.02745( 27.45ps)

## Comparison of pre-LAYOUT  and post-LAYOUT

Input pulse specification in both 
Rise Time-
Fall Time-
On time-
Period-

Pre-Layout Delay Vout-Vin - 
Post-Layout Delay Vout-Vin - 27.45ps
