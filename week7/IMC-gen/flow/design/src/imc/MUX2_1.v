module MUX2_1(
       	input in1, 
	input in2, 
	input sel,
	output out
);

assign out = sel?in2:in1;

endmodule
