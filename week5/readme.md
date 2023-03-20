## GDS generation of 1-bit ADC and verifying layout functionality using NGSPICE
Chosen ADC architecture - Flash type  

We use a open-loop OP-AMP which will function as a comparator. To it's non-inverting terminal, we apply the analog input from ring oscillator which is a periodic signal with amplitude 1.8V. This input will be modelled as a sinusoidal source in our schematic. To the inverting terminal, we apply a reference signal of VREF = 0.9V. When analog input is greater than VREF, the output will be positive supply voltage +VCC, resulting in positive saturation at the output. When it is less than VREF, the output will be negative supply voltag(here 0V), resulting in a negative saturation at the output. The output waveform is a 1-bit discrete signal and is our desired 1-bit ADC output.

![ezgif-2-f14b8dd1d5](https://user-images.githubusercontent.com/50217106/225022772-5a5328e0-358e-4b11-9254-6b7dcc2dc1b6.jpg)>

## 2 stage CMOS OPAMP schematic - Testing in Differential Mode

![Screenshot from 2023-03-16 03-50-05](https://user-images.githubusercontent.com/50217106/225456631-bcaaf820-9ed7-49ed-875d-81c96c511e2d.png)

![Screenshot from 2023-03-16 03-49-53](https://user-images.githubusercontent.com/50217106/225456637-59a87e08-137d-4a55-a052-c9f2b5776ac9.png)

It is necessary to size the transistors correctly to get the desired output. For amplifier design, we need to make sure all the transistors are in saturation. Digital sizing techniques are not applicable in CMOS analog design.

## ADC using OPAMP - PreLayout

To provide the reference voltage at inverting terminal of OP-AMP, two diode connected mosfets are used. A diode connected mosfet acts as a resistor of resistance 1/gm.  
Potential at the referene node supposed to be 0.9 is noisy but SNR is small as shown below
![Screenshot from 2023-03-16 03-09-31](https://user-images.githubusercontent.com/50217106/225452408-89c2574b-d5eb-4d24-b33f-27603df8577a.png)

![Screenshot from 2023-03-16 03-11-00](https://user-images.githubusercontent.com/50217106/225452116-20e74258-cbf7-4714-956c-2530546864c4.png)

![Screenshot from 2023-03-15 14-06-41](https://user-images.githubusercontent.com/50217106/225452846-0ad20563-9755-4815-8b50-2913adbee8a4.png)

![Screenshot from 2023-03-16 03-10-54](https://user-images.githubusercontent.com/50217106/225452145-5143c7f1-0f61-4a36-8c4e-abe9ce503c91.png)

![Screenshot from 2023-03-16 03-10-28](https://user-images.githubusercontent.com/50217106/225452172-27879a37-6a7a-4cf7-a287-7a9484524f1c.png)

- Pre-Layout Schematic

```
** sch_path: /home/rahul/Documents/adc/adc_top.sch
**.subckt adc_top VDD out VDD VDD vin vin
*.iopin VDD
*.opin out
*.iopin VDD
*.iopin VDD
*.ipin vin
*.ipin vin
x1 VDD out vin net1 GND adc_down
XM1 VDD VDD net1 net1 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM3 net1 net1 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
V2 VDD GND 1.8
.save i(v2)
V1 vin GND sin(0.9 0.9 50Meg)
.save i(v1)
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

* expanding   symbol:  /home/rahul/Documents/adc/adc_down.sym # of pins=5
** sym_path: /home/rahul/Documents/adc/adc_down.sym
** sch_path: /home/rahul/Documents/adc/adc_down.sch
.subckt adc_down VDD OUT Vp Vn VSS
*.ipin Vn
*.ipin Vp
*.iopin VDD
*.iopin VSS
*.opin OUT
XM1 net3 Vp net1 net1 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM2 net2 Vn net1 net1 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM3 net2 net2 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=2 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM4 net3 net2 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=2 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM5 net1 net4 VSS VSS sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM6 VDD VDD net4 net4 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM7 net4 net4 VSS VSS sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM8 OUT net3 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=4 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM9 OUT net4 VSS VSS sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends

.GLOBAL GND
```

# ADC layout using ALIGN and postlayout analysis


.sp 
```
.subckt adc_down VDD OUT Vp Vn VSS
XM1 net3 Vp net1 net1 sky130_fd_pr__nfet_01v8 L=150n W=420n
XM2 net2 Vn net1 net1 sky130_fd_pr__nfet_01v8 L=150n W=420n
XM3 net2 net2 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=840n
XM4 net3 net2 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=840n
XM5 net1 net4 VSS VSS sky130_fd_pr__nfet_01v8 L=150n W=420n
XM6 VDD VDD net4 net4 sky130_fd_pr__nfet_01v8 L=150n W=420n
XM7 net4 net4 VSS VSS sky130_fd_pr__nfet_01v8 L=150n W=420n
XM8 OUT net3 VDD VDD sky130_fd_pr__pfet_01v8 L=150n W=1680n
XM9 OUT net4 VSS VSS sky130_fd_pr__nfet_01v8 L=150n W=420n
.ends adc_down
```

gds
![Screenshot from 2023-03-16 13-12-07](https://user-images.githubusercontent.com/50217106/226037671-3f8255ac-46df-4581-a348-cb2911496a36.png)

gds read in magic

![Screenshot from 2023-03-16 13-21-28](https://user-images.githubusercontent.com/50217106/226037763-d6b12046-74a2-4a00-a038-eee167b7de89.png)


generated spice



spice with pre-layout excitations

![Screenshot from 2023-03-16 13-53-09](https://user-images.githubusercontent.com/50217106/226037806-5b59cb3c-0ffc-49cd-a85a-a1ed12a7ab05.png)

No matter what is the W and L value and nf corresponding to a W and L the output is always clamped to VDD for this schematic
## Verilog files required as input to the openFASOC flow for verilog generation
### Top level 
```
module async4bituc(
 input VDD,
 input VSS,
 input in,
 input vref,
 output out
 );
 wire interface;
 
 onebitADC adc1(
 .VDD(VDD), .VSS(VSS), .vin(interface), .out(out), .vref(vref)
 );
 
 ringosc osc1(
 .VDD(VDD), .VSS(VSS), .out(interface)
 );
 
endmodule
```
### ring oscillator
```
module ringosc(
 input VDD,
 input GND,
 output osc
 
);

endmodule
```
### 1-bit ADC
```
module onebitADC(
 input VDD,
 input VSS,
 input vin,
 input vref,
 output out
);


endmodule
```
