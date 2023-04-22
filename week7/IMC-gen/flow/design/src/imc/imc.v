module imc(  
	input WBL1, 
	input WBLB1, 
	input WBL2, 
	input WBLB2, 
	input RWL, 
	input WWL, 
	input SEL, 
	input RBLprecharge, 
	input RBLprechargeEnable,
	output out, Q1, Q2
);
wire inter1;
wire inter2;

SRAMLOGIC sramlogic(.WBL1(WBL1), .WBLB1(WBLB1), .WBL2(WBL2), .WBLB2(WBLB2), .OR(inter1), .NOR(inter2), .Q1(Q1), .Q2(Q2), 
	.RBLprechargeEnable(RBLprechargeEnable), .RBLprecharge(RBLprecharge), .RWL(RWL), .WWL(WWL)
);

MUX2_1 mux(.in1(inter1), .in2(inter2), .out(out), .sel(SEL)
);


endmodule


