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












