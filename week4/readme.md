## 4-bit Asynchronous UP counter with OpenFASOC

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
As per the findings in week2 that - ALIGN generates correct Layout when PFETs and NFETs form two collections in the .spice(pfets imported at once and bfets imported at once in xschem) is not completely correct. While making this ring oscillator schematic this was taken care, still ALIGN gives some error. If this erroneous layout is extrated in magic then the .spice will not have out pin. ALIGN is looking for patterns in .sp file for generating layout. 
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
