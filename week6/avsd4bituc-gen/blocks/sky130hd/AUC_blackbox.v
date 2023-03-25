(* blackbox *) module adc1(
  input vin,
  input VDD,
  input VSS,
  input vref,
  output out
);
endmodule
(* keep_hierarchy *)
(* blackbox *) module osc1(
  input VDD,
  input VSS,
  output osc
);
parameter dont_touch = "on";
endmodule
