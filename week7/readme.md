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

