## openFASOC
openFASOC is a project focused on automated analog generation from user specification to GDSII with fully open-sourced tools. It is inspired from FASoC which sits on proprietary software. FASoC: Fully-Autonomous SoC Synthesis using Customizable Cell-Based Synthesizable Analog Circuits. The FASoC Program is focused on developing a complete system-on-chip(SoC) synthesis tool from user specification to GDSII. FASoC leverages a differentiating technology to automatically synthesize "correct-by-construction" Verilog descriptions for both analog and digital circuits and nable a protable, single pass implementation flow. The SoC synthesis tool realizes analog circuits, including PLLs, power management, ADCs, and sensor interfaces by recasting them as structures composed largely of digital components while maintaining analog performance. They are then expressed as synthesizable Verilog blocks composed of digital standard cells augmented with a few auxilliary cells generated with an automatic cell generation tool. This project is led by a team of researcheers at the Universities of Michigan, Virginia,a nd ARM.

## Installation of openFASOC
```
$ git clone https://github.com/idea-fasoc/openfasoc
$ sudo ./dependencies.sh

```

## OpenROAD
OpenROAD is a foundational building block in open-source digital flow like OpenROAD-flow-scripts, OpenLANE from Efabless, Silicon Compiler Systems; as well as OpenFASoC for mixed-signal design flow.

## Installtion of OpenROAD


## Testing installation of OpenROAD
```
cd OpenROAD-flow-scripts
cd flow
make DESIGN_CONFIG=./designs/sky130hd/ibex/config.mk
```
![Screenshot from 2023-02-26 16-40-11](https://user-images.githubusercontent.com/50217106/221414408-2727fef3-905a-43f6-bd9f-720ccf99e506.png)
To view the design that is generated suing this test command 
```
$ make DESIGN_CONFIG=./designs/sky130hd/ibex/config.mk gui_final
```
![Screenshot from 2023-02-26 17-46-08](https://user-images.githubusercontent.com/50217106/221414499-7d4c1d2c-36ee-48aa-80f2-357638f82137.png)

## Temperature sensor Auxilliary Cells


## OpenROAD flow for Temperature sensor
