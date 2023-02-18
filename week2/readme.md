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

