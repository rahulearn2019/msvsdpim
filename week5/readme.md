## GDS generation of 1-bit ADC using ALIGN and post-layout simulations with NGSPICE
- Chosen ADC architecture - Flash type  

We use a open-loop OP-AMP which will function as a comparator. To it's non-inverting terminal, we apply the analog input from ring oscillator which is a periodic signal with amplitude 1.8V. This input will be modelled as a sinusoidal source in our schematic. To the inverting terminal, we apply a reference signal of VREF = 0.9V. When analog input is greater than VREF, the output will be positive supply voltage +VCC, resulting in positive saturation at the output. When it is less than VREF, the output will be negative supply voltag(here 0V), resulting in a negative saturation at the output. The output waveform is a 1-bit discrete signal and is our desired 1-bit ADC output.

![ezgif-2-f14b8dd1d5](https://user-images.githubusercontent.com/50217106/225022772-5a5328e0-358e-4b11-9254-6b7dcc2dc1b6.jpg)>

## 2 stage CMOS OPAMP schematic - Testing in Differential Mode

![Screenshot from 2023-03-16 03-50-05](https://user-images.githubusercontent.com/50217106/225456631-bcaaf820-9ed7-49ed-875d-81c96c511e2d.png)

![Screenshot from 2023-03-16 03-49-53](https://user-images.githubusercontent.com/50217106/225456637-59a87e08-137d-4a55-a052-c9f2b5776ac9.png)

It is necessary to size the transistors correctly to get the desired output. For amplifier design, we need to make sure all the transistors are in saturation. Digital sizing techniques are not applicable in CMOS analog design.

## ADC using OPAMP - PreLayout

To provide the reference voltage at inverting terminal of OP-AMP, two diode connected mosfets are used. A diode connected mosfet acts as a resistor of resistance 1/gm (gm = transconductance of FET small signal model) 
Potential at the referene node supposed to be 0.9 is noisy but SNR is small as shown below
![Screenshot from 2023-03-16 03-09-31](https://user-images.githubusercontent.com/50217106/225452408-89c2574b-d5eb-4d24-b33f-27603df8577a.png)

![Screenshot from 2023-03-16 03-11-00](https://user-images.githubusercontent.com/50217106/225452116-20e74258-cbf7-4714-956c-2530546864c4.png)

![Screenshot from 2023-03-15 14-06-41](https://user-images.githubusercontent.com/50217106/225452846-0ad20563-9755-4815-8b50-2913adbee8a4.png)

![Screenshot from 2023-03-16 03-10-54](https://user-images.githubusercontent.com/50217106/225452145-5143c7f1-0f61-4a36-8c4e-abe9ce503c91.png)

![Screenshot from 2023-03-16 03-10-28](https://user-images.githubusercontent.com/50217106/225452172-27879a37-6a7a-4cf7-a287-7a9484524f1c.png)

## OPAMP modifications 
The output of ompamp functioning as comparator will be an input to our digital block in the mixed signal design. There are several techniques used to minimize noise and obtain an ideal input for the digital block. An ideal input has minimum input signal transition(slew), complete signal swing and mimimum or no noise at all. To achive it a chain of inverters are added at the output to act as an interface circuitry and provide a near ideal signal to the digital block.

### xschem schematic
![Screenshot from 2023-03-27 23-56-46](https://user-images.githubusercontent.com/50217106/228069927-3a2dce30-5de4-47fa-999e-4a2a55d273ea.png)
![Screenshot from 2023-03-28 02-41-14](https://user-images.githubusercontent.com/50217106/228069947-54fece19-d64c-4d82-ba99-64c37cfa3fb0.png)

### ngspice simulation

![Screenshot from 2023-03-28 02-55-40](https://user-images.githubusercontent.com/50217106/228070431-50080679-d4a6-4342-9de6-6edfc3f7619c.png)
### Advantage of adding inverter chain
The second output is taken directly from the 2nd stage of TWO stage CMOS Op-Amp. The first one is after using the inverter chain

![Screenshot from 2023-03-20 02-25-07](https://user-images.githubusercontent.com/50217106/228073129-b2a22a07-29f2-4488-b8c0-66090f71ce1b.png)

### pre-layout spice netlist
```
** sch_path: /home/rahul/Documents/adcSingular/adc_tb.sch
**.subckt adc_tb out vin vref vin vref
*.opin out
*.ipin vin
*.ipin vref
*.ipin vin
*.ipin vref
V1 VDD GND 1.8
.save i(v1)
V2 vin GND sin(0.9 0.9 50Meg)
.save i(v2)
V3 vref GND 0.9
.save i(v3)
x1 VDD out vin vref GND adc_flash
**** begin user architecture code

.tran 0.01n 100n
.save all


.param mc_mm_switch=0
.param mc_pr_switch=0
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/corners/tt.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/r+c/res_typical__cap_typical.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/r+c/res_typical__cap_typical__lin.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/corners/tt/specialized_cells.spice

**** end user architecture code
**.ends

* expanding   symbol:  /home/rahul/Documents/adcSingular/adc_flash.sym # of pins=5
** sym_path: /home/rahul/Documents/adcSingular/adc_flash.sym
** sch_path: /home/rahul/Documents/adcSingular/adc_flash.sch
.subckt adc_flash VDD out vin vref GND
*.ipin vin
*.iopin GND
*.opin out
*.iopin VDD
*.ipin vref
XM1 net3 vin net1 GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM2 net2 vref net1 GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM3 net3 net2 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM4 net2 net2 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM7 net1 net4 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM8 net4 net4 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM9 VDD VDD net4 GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM5 net5 net3 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM6 net5 net4 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM10 net6 net5 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM11 net6 net5 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM12 out net6 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM13 out net6 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends

.GLOBAL GND
.GLOBAL VDD
.end

```

---> NOTE - The ADC circuit in the hierarchy has an I/O pin that shows GND pin. DO not name it as VSS or something. It will create problems in post-layout spice simulations. As NGSPICE understands GND and doesn't like any other name for it, even if it is in a subckt

![Screenshot from 2023-03-28 01-23-59](https://user-images.githubusercontent.com/50217106/228070895-d100f490-445d-4f18-a7f2-06f5186c06f3.png)

# ADC layout using ALIGN and postlayout SPICE analysis
- .sp fed to ALIGN  
```
.subckt adc_flash vin GND out VDD vref
XM1 net3 vin net1 GND sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
XM2 net2 vref net1 GND sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
XM3 net3 net2 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=4
XM4 net2 net2 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=4
XM7 net1 net4 GND GND sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
XM8 net4 net4 GND GND sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
XM9 VDD VDD net4 GND sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
XM5 net5 net3 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=4
XM6 net5 net4 GND GND sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
XM10 net6 net5 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=4
XM11 net6 net5 GND GND sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
XM12 out net6 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1050n nf=4
XM13 out net6 GND GND sky130_fd_pr__nfet_01v8 L=150n W=1050n nf=4
.ends

```

## GDS view in klayout

![Screenshot from 2023-03-28 03-01-34](https://user-images.githubusercontent.com/50217106/228071572-7456a112-1a89-45da-8211-0543cf5e9e5d.png)

## Import GDS in magic
Remove the ports imported by magic as they are the main source of problem in post layout simulations. Relabel the ports
- check the layer they are present in by using ```what``` command over a port selected by ```select area``` command in tkcon window.  
- To remove port use - ```port remove``` command and to remove label use ```erase label``` command
- Then add label at the exact same location on the exact same layer, you may need to add a specific layers where the port layer is not accessible

![Screenshot from 2023-03-28 02-40-32](https://user-images.githubusercontent.com/50217106/228071735-33736dae-803e-4179-a4ed-2eb98acd1171.png)

After adding ports use    
 ```port makeall```   
Now extract the layout to obtain spice netlist
```
extract all
ext2spice cthresh 0 rthresh 0
ext2spice
```

### Post-Layout spice after adding pre-layput excitations and lib definitions
```
* SPICE3 file created from ADC_FLASH_0.ext - technology: sky130A
V1 VDD GND 1.8
.save i(v1)
V2 vin GND sin(0.9 0.9 50Meg)
.save i(v2)
V3 vref GND 0.9
.save i(v3)
x1 VDD out vin vref GND adc_flash
**** begin user architecture code

.tran 0.01n 100n
.save all


.param mc_mm_switch=0
.param mc_pr_switch=0
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/corners/tt.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/r+c/res_typical__cap_typical.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/r+c/res_typical__cap_typical__lin.spice
.include /usr/local/share/pdk/sky130A/libs.tech/ngspice/corners/tt/specialized_cells.spice

**** end user architecture code
**.ends

* expanding   symbol:  /home/rahul/Documents/adcSingular/adc_flash.sym # of pins=5
** sym_path: /home/rahul/Documents/adcSingular/adc_flash.sym
** sch_path: /home/rahul/Documents/adcSingular/adc_flash.sch
.subckt adc_flash VDD out vin vref GND
X0 VDD VDD m1_1860_1484# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X1 m1_1860_1484# VDD VDD GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X2 VDD VDD m1_1860_1484# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X3 m1_1860_1484# VDD VDD GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X4 m1_656_1568# m1_656_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X5 VDD m1_656_1568# li_1953_2335# VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X6 VDD m1_656_1568# m1_656_1568# VDD sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X7 li_1953_2335# m1_656_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X8 m1_656_1568# m1_656_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X9 VDD m1_656_1568# m1_656_1568# VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X10 VDD m1_656_1568# li_1953_2335# VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X11 li_1953_2335# m1_656_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X12 m1_2322_1316# m1_1860_1484# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X13 m1_1860_1484# m1_1860_1484# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X14 GND m1_1860_1484# m1_2322_1316# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X15 GND m1_1860_1484# m1_1860_1484# GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X16 m1_2322_1316# m1_1860_1484# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X17 m1_1860_1484# m1_1860_1484# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X18 GND m1_1860_1484# m1_1860_1484# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X19 GND m1_1860_1484# m1_2322_1316# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X20 m1_516_1652# m1_1860_1484# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X21 GND m1_1860_1484# m1_516_1652# GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X22 m1_516_1652# m1_1860_1484# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X23 GND m1_1860_1484# m1_516_1652# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X24 VDD STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# OUT VDD sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X25 OUT STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X26 VDD STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# OUT VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X27 OUT STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X28 VDD m1_2322_1316# STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=3.99 pd=37 as=0.588 ps=5.32 w=1.05 l=0.15
X29 STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# m1_2322_1316# VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X30 VDD m1_2322_1316# STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X31 STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# m1_2322_1316# VDD VDD sky130_fd_pr__pfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X32 OUT STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X33 GND STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# OUT GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X34 OUT STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# GND GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X35 GND STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# OUT GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X36 STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# m1_2322_1316# GND GND sky130_fd_pr__nfet_01v8 ad=0.588 pd=5.32 as=3.99 ps=37 w=1.05 l=0.15
X37 GND m1_2322_1316# STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X38 STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# m1_2322_1316# GND GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X39 GND m1_2322_1316# STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X40 m1_656_1568# VREF m1_516_1652# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X41 m1_516_1652# VREF m1_656_1568# GND sky130_fd_pr__nfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X42 m1_656_1568# VREF m1_516_1652# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X43 m1_516_1652# VREF m1_656_1568# GND sky130_fd_pr__nfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X44 li_1953_2335# VIN m1_516_1652# GND sky130_fd_pr__nfet_01v8 ad=0.588 pd=5.32 as=2.289 ps=21.16 w=1.05 l=0.15
X45 m1_516_1652# VIN li_1953_2335# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X46 li_1953_2335# VIN m1_516_1652# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X47 m1_516_1652# VIN li_1953_2335# GND sky130_fd_pr__nfet_01v8 ad=0 pd=0 as=0 ps=0 w=1.05 l=0.15
X48 VDD li_1953_2335# m1_2322_1316# VDD sky130_fd_pr__pfet_01v8 ad=0.27825 pd=2.63 as=0.147 ps=1.33 w=1.05 l=0.15
X49 m1_2322_1316# li_1953_2335# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.27825 ps=2.63 w=1.05 l=0.15
X50 VDD li_1953_2335# m1_2322_1316# VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
X51 m1_2322_1316# li_1953_2335# VDD VDD sky130_fd_pr__pfet_01v8 ad=0.147 pd=1.33 as=0.147 ps=1.33 w=1.05 l=0.15
C0 m1_2322_1316# VDD 4.01fF
C1 m1_516_1652# m1_1860_1484# 0.28fF
C2 VREF m1_516_1652# 0.16fF
C3 GND m1_516_1652# 0.19fF
C4 li_1953_2335# m1_516_1652# 1.68fF
C5 OUT VDD 1.63fF
C6 m1_2322_1316# m1_516_1652# 0.00fF
C7 STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# m1_1860_1484# 0.01fF
C8 GND STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# 0.55fF
C9 li_1953_2335# STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# 0.00fF
C10 VREF m1_1860_1484# 0.00fF
C11 GND m1_1860_1484# 1.07fF
C12 GND VREF 0.03fF
C13 VIN m1_656_1568# 0.01fF
C14 m1_2322_1316# STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# 0.84fF
C15 VIN VDD 0.01fF
C16 li_1953_2335# m1_1860_1484# 0.05fF
C17 li_1953_2335# VREF 0.31fF
C18 li_1953_2335# GND 0.34fF
C19 m1_2322_1316# m1_1860_1484# 0.90fF
C20 m1_2322_1316# VREF 0.00fF
C21 m1_2322_1316# GND 0.91fF
C22 OUT STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# 0.47fF
C23 m1_2322_1316# li_1953_2335# 0.26fF
C24 VIN m1_516_1652# 0.23fF
C25 OUT m1_1860_1484# 0.00fF
C26 OUT GND 0.04fF
C27 OUT li_1953_2335# 0.00fF
C28 m1_2322_1316# OUT 0.01fF
C29 VIN VREF 0.04fF
C30 VIN GND 0.01fF
C31 VIN li_1953_2335# 0.25fF
C32 m1_656_1568# VDD 5.13fF
C33 m1_656_1568# m1_516_1652# 1.63fF
C34 m1_516_1652# VDD 0.50fF
C35 STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# VDD 4.25fF
C36 m1_656_1568# m1_1860_1484# 0.04fF
C37 VREF m1_656_1568# 0.20fF
C38 GND m1_656_1568# 0.03fF
C39 VDD m1_1860_1484# 2.13fF
C40 VREF VDD 0.04fF
C41 GND VDD 1.11fF
C42 li_1953_2335# m1_656_1568# 0.98fF
C43 m1_2322_1316# m1_656_1568# 0.00fF
C44 li_1953_2335# VDD 3.76fF
C45 m1_516_1652# 0 1.39fF 
**FLOATING
C46 VDD 0 11.56fF 
**FLOATING
C47 VIN 0 1.07fF 
**FLOATING
C48 VREF 0 1.03fF 
**FLOATING
C49 m1_2322_1316# 0 1.78fF 
**FLOATING
C50 OUT 0 1.22fF 
**FLOATING
C51 STAGE2_INV_3570141_0_0_1679948385_0/li_663_571# 0 1.36fF 
**FLOATING
C52 m1_1860_1484# 0 4.73fF 
**FLOATING
.ends

.GLOBAL VDD
.GLOBAL GND
.end

```

### Ngspice simulation output


![Screenshot from 2023-03-28 02-39-26](https://user-images.githubusercontent.com/50217106/228072557-6e6ed2ee-9e7d-4c95-b5de-e76eab6dc155.png)

Clearly, Pre-layout matches post-layout










## Verilog files required as input to the openFASOC flow for verilog generation
### Top level 
```verilog
module async4bituc(
 input VDD,
 input VSS,
 input vref,
 output out
 );
 wire inter1;
 
 onebitADC adc1(
 .VDD(VDD), .VSS(VSS), .vin(inter1), .out(out), .vref(vref)
 );
 
 ringosc osc1(
 .VDD(VDD), .VSS(VSS), .osc(inter1)
 );
 
endmodule
```
### ring oscillator
```verilog
module ringosc(
 input VDD,
 input VSS,
 output osc
 
);

endmodule
```
### 1-bit ADC
```verilog
module onebitADC(
 input VDD,
 input VSS,
 input vin,
 input vref,
 output out
);


endmodule
```
