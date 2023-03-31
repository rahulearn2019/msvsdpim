module async4bituc(
	input VDD,
	input VSS,
	input vref,
	output out
);

wire inter1;

onebitADC adc1(
	.VDD(VDD),
	.OUT(out),
	.VIN(inter1),
	.VREF(vref),
	.GND(VSS)
);

RINGOSC osc1(
	.VDD(VDD),
	.OUT(inter1),
	.GND(VSS)
);


endmodule
