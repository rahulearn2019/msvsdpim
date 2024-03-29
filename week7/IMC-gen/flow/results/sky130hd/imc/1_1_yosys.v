/* Generated by Yosys 0.13+15 (git sha1 bc027b2ca, gcc 9.4.0-1ubuntu1~20.04.1 -fPIC -Os) */

module imc(WBL1, WBLB1, WBL2, WBLB2, RWL, WWL, SEL, RBLprecharge, RBLprechargeEnable, out, Q1, Q2);
  output Q1;
  output Q2;
  input RBLprecharge;
  input RBLprechargeEnable;
  input RWL;
  input SEL;
  input WBL1;
  input WBL2;
  input WBLB1;
  input WBLB2;
  input WWL;
  wire \mux.in1 ;
  wire \mux.in2 ;
  output out;
  sky130_fd_sc_hd__mux2_4 _0_ (
    .A0(\mux.in1 ),
    .A1(\mux.in2 ),
    .S(SEL),
    .X(out)
  );
  SRAMLOGIC sramlogic (
    .NOR(\mux.in2 ),
    .OR(\mux.in1 ),
    .Q1(Q1),
    .Q2(Q2),
    .RBLprecharge(RBLprecharge),
    .RBLprechargeEnable(RBLprechargeEnable),
    .RWL(RWL),
    .WBL1(WBL1),
    .WBL2(WBL2),
    .WBLB1(WBLB1),
    .WBLB2(WBLB2),
    .WWL(WWL)
  );
endmodule
