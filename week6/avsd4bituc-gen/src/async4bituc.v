module async4bituc(
	input VDD,
	input VSS,
	input vref,
	output out
);

wire inter1;

onebitADC adc1(
	.VDD(VDD),
	.VSS(VSS),
	.vin(inter1),
	.out(out),
	.vref(vref)
);

ringosc osc1(
	.VDD(VDD),
	.VSS(VSS),
	.osc(inter1)
);


endmodule
