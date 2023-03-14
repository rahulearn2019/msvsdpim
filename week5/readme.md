# 1-bit ADC
Chosen ADC architecture - Flash type  

We use a open-loop OP-AMP which will function as a comparator. To it's non-inverting terminal, we apply the analog input from ring oscillator which is a periodic signal with amplitude 1.8V. This input will be modelled as a sinusoidal source in our schematic. To the inverting terminal, we apply a reference signal of VREF = 0.9V. When analog input is greater than VREF, the output will be positive supply voltage +VCC, resulting in positive saturation at the output. When it is less than VREF, the output will be negative supply voltag(here 0V), resulting in a negative saturation at the output. The output waveform is a 1-bit discrete signal and is our desired 1-bit ADC output.

![image](https://user-images.githubusercontent.com/50217106/225019619-bba993b7-fbaa-42ed-9f48-c6261769e793.png)
