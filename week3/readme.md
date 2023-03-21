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
export OPENROAD=~/OpenROAD-flow-scripts/tools/OpenROAD
export PATH=/home/rahul/OpenROAD-flow-scripts/tools/install/OpenROAD/bin:/home/rahul/OpenROAD-flow-scripts/tools/install/yosys/bin:/home/rahul/OpenROAD-flow-scripts/tools/install/LSOracle/bin:$PATH
```
## Testing installation of OpenROAD
We perform RTL2GDS of ibex. ibex is a 32 bit RISC-V CPU core ( RV32IMC/EMC ) with a two-stage pipeline. 
```
cd OpenROAD-flow-scripts
cd flow
make DESIGN_CONFIG=./designs/sky130hd/ibex/config.mk
```
![Screenshot from 2023-02-26 16-40-11](https://user-images.githubusercontent.com/50217106/221414408-2727fef3-905a-43f6-bd9f-720ccf99e506.png)
OpenROAD performs 6 iterations to reach the optimized design with the algorthms it uses to perform RTL2GDS.
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

### Circuit
This generator creates a compact mixed-signal temperature sensor. It consists of a ring oscillator whose frequency is controlled by the voltage drop over a MOSFET operating in subthreshold regime, where its dependency on temperature is exponential.

![image](https://user-images.githubusercontent.com/50217106/221423346-0e487e79-5845-4a6f-a3c1-5ca66f034d7e.png)

The physical implementation of the analog blocks in the circuit is done using two manually designed standard cells:
 1. HEADER cell, containing the transistors in subthreshold operation;
 2. SLC cell, containing the Split-Control Level Converter.
 3. 
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
To run verilog generation, type the command ```make sky130hd_temp_verilog```
![Screenshot from 2023-02-26 21-29-13](https://user-images.githubusercontent.com/50217106/221421589-717aedf0-c2c1-4acf-90b6-da178d9d6e64.png)

Viewing the GDS view of the temperature generator using klayout-

![Screenshot from 2023-02-26 17-50-19](https://user-images.githubusercontent.com/50217106/221420863-1664b395-33bf-4a11-a679-04900a5aa84b.png)

To run the default generator, ```cd``` into ```~/openfasoc/generators/temp_sense``` and use 
```make sky130hd_temp```
If a PDK_ROOT error arises, then provide PDK_ROOT before running the above 
```export PDK_ROOT=usr/local/share/pdk```
If OpenROAD not found in path error arises, provide path to openROAD along with PDK_ROOT 
```
export OPENROAD=~/OpenROAD-flow-scripts/tools/OpenROAD/
export PATH=/home/rahul/OpenROAD-flow-scripts/tools/install/OpenROAD/bin:/home/rahul/OpenROAD-flow-scripts/tools/install/yosys/bin:/home/rahul/OpenROAD-flow-scripts/tools/install/LSOracle/bin:$PATH
```

After a successful run the following message is displayed

![Screenshot from 2023-02-26 14-08-37](https://user-images.githubusercontent.com/50217106/221420486-877d2b7a-b937-41f8-a129-cee7dbeae548.png)

In the following directory all the files corresponding to different stages of the RTL2GDS flow is saved.

![Screenshot from 2023-02-26 17-53-39](https://user-images.githubusercontent.com/50217106/221422433-ee88f14f-24be-45f7-8a4a-0b1bea51b39c.png)

#### Reference
- https://openfasoc.readthedocs.io/en/latest/flow-tempsense.html
