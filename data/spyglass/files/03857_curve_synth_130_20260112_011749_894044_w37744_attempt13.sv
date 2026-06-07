module curve_synth_130_20260112_011749_894044_w37744_attempt13 (
    // Inputs
    in1,
    in2,
    control1,
    control2,
    // Outputs
    out1,
    out2,
    out3,
    out4,
    out5
);

input in1;
input in2;
input control1;
input control2;

output out1;
output out2;
output out3;
output out4;
output out5;

wire out1;
wire out2;
wire out3;
wire out4;
wire out5;

  // Each nmos instance below will trigger a SYNTH_130 violation (nmos gate types are not supported)
  nmos nmos_inst_a (out1, in1, control1);
  nmos nmos_inst_b (out2, in2, control2);
  nmos nmos_inst_c (out3, in1, control2);
  nmos nmos_inst_d (out4, 1'b0, control1);
  nmos nmos_inst_e (out5, in2, 1'b1);

endmodule
