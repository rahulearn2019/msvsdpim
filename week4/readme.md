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

### GDS read in Magic




### spice simulation of extracted layout
generated .spice
```

```
final .spice to ngspice
```

```
simulation





### changing nf=2 from nf=10 and simulation



