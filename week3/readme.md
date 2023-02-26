## openFASOC
openFASOC is a project focused on automated analog generation from user specification to GDSII with fully open-sourced tools. It is inspired from FASoC which sits on proprietary software. FASoC: Fully-Autonomous SoC Synthesis using Customizable Cell-Based Synthesizable Analog Circuits. The FASoC Program is focused on developing a complete system-on-chip(SoC) synthesis tool from user specification to GDSII. FASoC leverages a differentiating technology to automatically synthesize "correct-by-construction" Verilog descriptions for both analog and digital circuits and nable a protable, single pass implementation flow. The SoC synthesis tool realizes analog circuits, including PLLs, power management, ADCs, and sensor interfaces by recasting them as structures composed largely of digital components while maintaining analog performance. They are then expressed as synthesizable Verilog blocks composed of digital standard cells augmented with a few auxilliary cells generated with an automatic cell generation tool. This project is led by a team of researcheers at the Universities of Michigan, Virginia,a nd ARM.

## Installation of openFASOC
```
$ git clone https://github.com/idea-fasoc/openfasoc
$ sudo ./dependencies.sh

```
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
OpenROAD is a foundational building block in open-source digital flow like OpenROAD-flow-scripts, OpenLANE from Efabless, Silicon Compiler Systems; as well as OpenFASoC for mixed-signal design flow.

## Installtion of OpenROAD


## Testing installation of OpenROAD
We perform RTL2GDS of ibex RISC-V 32 bit CPU core
```
cd OpenROAD-flow-scripts
cd flow
make DESIGN_CONFIG=./designs/sky130hd/ibex/config.mk
```
![Screenshot from 2023-02-26 16-40-11](https://user-images.githubusercontent.com/50217106/221414408-2727fef3-905a-43f6-bd9f-720ccf99e506.png)
OpenROAD performs 6 iterations to reach the optimized design with the algorthms it uses to perform RTL2GDS.
![Screenshot from 2023-02-26 16-59-39](https://user-images.githubusercontent.com/50217106/221416830-ded37c1c-1c7c-44ff-ab04-8395baf46e01.png)
To view the design that is generated suing this test command 
```
$ make DESIGN_CONFIG=./designs/sky130hd/ibex/config.mk gui_final
```
![Screenshot from 2023-02-26 17-46-08](https://user-images.githubusercontent.com/50217106/221414499-7d4c1d2c-36ee-48aa-80f2-357638f82137.png)

## Temperature sensor Auxilliary Cells


## OpenROAD flow for Temperature sensor
