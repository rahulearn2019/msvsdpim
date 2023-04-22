(* blackbox *) module adc1(
  input VDD,
  output OUT,
  input VIN,
  input VREF,
  input VSS
);
endmodule
(* keep_hierarchy *)
(* blackbox *) module osc1(
  input VDD,
  output OUT,
  input GND
);
parameter dont_touch = "on";
endmodule
