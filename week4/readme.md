## 4-bit Asynchronous UP counter with OpenFASOC

### Ring oscillator schematic and Testbench and Simulation

![Screenshot from 2023-03-03 15-43-43](https://user-images.githubusercontent.com/50217106/222694226-e67ce089-24cd-44cc-871c-eaa41e7fb08d.png)

![Screenshot from 2023-03-03 15-43-26](https://user-images.githubusercontent.com/50217106/222694259-4bc75e31-6153-4831-8dcc-613f06cdda7b.png)

![Screenshot from 2023-03-03 15-44-33](https://user-images.githubusercontent.com/50217106/222694293-c8503a3f-abb7-4e7d-9b5f-cf37bc807aca.png)

![Screenshot from 2023-03-03 15-44-44](https://user-images.githubusercontent.com/50217106/222694442-b38d03c4-ca53-4656-86a9-b585f4b8790b.png)


### .spice RING oscilator
```
** sch_path: /home/rahul/Documents/ring1/ring1T.sch
**.subckt ring1T out
*.opin out
x1 VDD out GND ring1
V1 VDD GND 1.8
.save i(v1)
**** begin user architecture code

.param mc_mm_switch=0
.param mc_pr_switch=0
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/corners/tt.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/r+c/res_typical__cap_typical.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/r+c/res_typical__cap_typical__lin.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/corners/tt/specialized_cells.spice


.tran 0.01n 10n
.save all

**** end user architecture code
**.ends

* expanding   symbol:  /home/rahul/Documents/ring1/ring1.sym # of pins=3
** sym_path: /home/rahul/Documents/ring1/ring1.sym
** sch_path: /home/rahul/Documents/ring1/ring1.sch
.subckt ring1 VDD out GND
*.iopin VDD
*.iopin GND
*.opin out
XM1 out net2 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM2 net2 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM3 net1 out VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM4 out net2 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM5 net2 net1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM6 net1 out GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends

```

### .sp RING oscillator and ALIGN error when generating GDS
![Screenshot from 2023-03-02 23-30-15](https://user-images.githubusercontent.com/50217106/222692252-3a6f1dd7-db7b-41ce-8b35-06a36aa02466.png)

![Screenshot from 2023-03-02 23-29-48](https://user-images.githubusercontent.com/50217106/222692361-346232a7-93cf-4706-8785-349c4bf578ee.png)

### Manipulations in .sp 
As per the findings in week2 that - ALIGN generates correct Layout when PFETs and NFETs form two collections in the .spice(pfets imported at once and bfets imported at once in xschem) is not completely correct. While making this ring oscillator schematic this was taken care, still ALIGN gives some error. If this erroneous layout is extrated in magic then the .spice will not have out pin. ALIGN is looking for patterns in .sp file for generating 
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

X0 m1_742_2240# m1_774_4424# STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# m1_742_2240# sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X1 STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# m1_774_4424# m1_742_2240# m1_742_2240# sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X2 m1_742_2240# m1_774_4424# STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# m1_742_2240# sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X3 STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# m1_774_4424# m1_742_2240# m1_742_2240# sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X4 m1_430_1568# STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X5 VSUBS STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# m1_430_1568# VSUBS sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X6 m1_430_1568# STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X7 VSUBS STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# m1_430_1568# VSUBS sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X8 STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# m1_774_4424# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0.588 pd=5.32 as=2.5515 ps=23.76 w=1.05 l=0.15
X9 VSUBS m1_774_4424# STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# VSUBS sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X10 STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# m1_774_4424# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X11 VSUBS m1_774_4424# STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# VSUBS sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X12 m1_742_2240# STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# m1_430_1568# m1_742_2240# sky130_fd_pr__pfet_01v8 ad=2.5515 pd=23.76 as=0.588 ps=5.32 w=1.05 l=0.15
X13 m1_430_1568# STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# m1_742_2240# m1_742_2240# sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X14 m1_742_2240# STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# m1_430_1568# m1_742_2240# sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X15 m1_430_1568# STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# m1_742_2240# m1_742_2240# sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X16 m1_774_4424# m1_430_1568# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X17 VSUBS m1_430_1568# m1_774_4424# VSUBS sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X18 m1_774_4424# m1_430_1568# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X19 VSUBS m1_430_1568# m1_774_4424# VSUBS sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X20 m1_742_2240# m1_430_1568# m1_774_4424# m1_742_2240# sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X21 m1_774_4424# m1_430_1568# m1_742_2240# m1_742_2240# sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X22 m1_742_2240# m1_430_1568# m1_774_4424# m1_742_2240# sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X23 m1_774_4424# m1_430_1568# m1_742_2240# m1_742_2240# sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
C0 m1_430_1568# STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# 0.62fF
C1 m1_430_1568# m1_774_4424# 0.71fF
C2 VDD OUT 0.26fF
C3 GND VDD 1.07fF
C4 STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# m1_774_4424# 0.79fF
C5 m1_430_1568# VDD 1.13fF
C6 m1_430_1568# OUT 0.00fF
C7 m1_430_1568# m1_742_2240# 3.42fF
C8 m1_430_1568# GND 0.05fF
C9 STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# VDD 0.13fF
C10 STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# OUT 0.01fF
C11 m1_742_2240# STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# 4.09fF
C12 VDD m1_774_4424# 0.15fF
C13 m1_742_2240# m1_774_4424# 3.44fF
C14 GND STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# 0.42fF
C15 VDD VSUBS 0.51fF
C16 m1_430_1568# VSUBS 2.95fF **FLOATING
C17 STAGE2_INV_3570141_0_0_1677780962_0/li_663_571# VSUBS 1.83fF **FLOATING
C18 m1_742_2240# VSUBS 10.22fF **FLOATING
C19 m1_774_4424# VSUBS 4.20fF **FLOATING
```
final .spice to ngspice
```

```
simulation

![Screenshot from 2023-02-28 01-24-50](https://user-images.githubusercontent.com/50217106/222695054-17e27079-61ba-4253-8336-7a0cbd285888.png)




### changing nf=2 from nf=10 and simulation



