module multiple_module_opt1(a, b, c, d, y);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  wire _4_;
  wire \U1.y ;
  input a;
  input b;
  input c;
  input d;
  output y;
  sky130_fd_sc_hd__a21o_2 _5_ (
    .A1(_1_),
    .A2(_4_),
    .B1(_2_),
    .X(_3_)
  );
  assign _1_ = b;
  assign _2_ = c;
  assign y = _3_;
  assign _4_ = a;
endmodule
