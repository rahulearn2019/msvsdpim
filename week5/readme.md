## GDS generation of 1-bit ADC and verifying layout functionality using NGSPICE
Chosen ADC architecture - Flash type  

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



### testbench



### ngspice simulation


### pre-layout spice netlist


---> NOTE - The ADC circuit in the hierarchy has an I/O pin that shows GND pin. DO not name it as VSS or something. It will create problems in post-layout spice simulations. As NGSPICE understands GND and doesn't like any other name for it, even if it is in a subckt

# ADC layout using ALIGN and postlayout SPICE analysis
- .sp fed to ALIGN  
```

```

## GDS view in klayout




## Import GDS in magic
Remove the ports imported by magic as they are the main source of problem in post layout simulations. Relabel the ports
- check the layer they are present in by using ```what``` command over a port selected by ```select area``` command in tkcon window.  
- To remove port use - ```port remove``` command and to remove label use ```erase label``` command
- Then add label at the exact same location on the exact same layer, you may need to add a specific layers where the port layer is not accessible
After adding ports use    
 ```port makeall```   
Now extract the layout to obtain spice netlist
 
 
### Post-Layout spice after adding pre-layput excitations and lib definitions
```


```

### Ngspice simulation output





Pre-layout matches post-layout










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
