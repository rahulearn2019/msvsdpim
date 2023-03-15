# 1-bit ADC
Chosen ADC architecture - Flash type  

We use a open-loop OP-AMP which will function as a comparator. To it's non-inverting terminal, we apply the analog input from ring oscillator which is a periodic signal with amplitude 1.8V. This input will be modelled as a sinusoidal source in our schematic. To the inverting terminal, we apply a reference signal of VREF = 0.9V. When analog input is greater than VREF, the output will be positive supply voltage +VCC, resulting in positive saturation at the output. When it is less than VREF, the output will be negative supply voltag(here 0V), resulting in a negative saturation at the output. The output waveform is a 1-bit discrete signal and is our desired 1-bit ADC output.

![ezgif-2-f14b8dd1d5](https://user-images.githubusercontent.com/50217106/225022772-5a5328e0-358e-4b11-9254-6b7dcc2dc1b6.jpg)

## OPAMP schematic - Testing in Common Mode
It is necessary to size the transistors correctly to get the desired output. For amplifier design, we need to make sure all the transistors are in saturation. Digital sizing techniques are not applicable in CMOS analog design.




## ADC using OPAMP

To provide the reference voltage at inverting terminal of OP-AMP, two diode connected mosfets are used. A diode connected mosfet acts as a resistor of resistance 1/gm.  
![Screenshot from 2023-03-16 03-11-00](https://user-images.githubusercontent.com/50217106/225452116-20e74258-cbf7-4714-956c-2530546864c4.png)
![Screenshot from 2023-03-16 03-10-54](https://user-images.githubusercontent.com/50217106/225452145-5143c7f1-0f61-4a36-8c4e-abe9ce503c91.png)
![Screenshot from 2023-03-16 03-10-28](https://user-images.githubusercontent.com/50217106/225452172-27879a37-6a7a-4cf7-a287-7a9484524f1c.png)

