module curve_stx_ve_332_20260111_173609_008627_w47100_attempt9 (
  input in1,
  input in2
);

  // STX_VE_332: Gate 'and' has invalid output specification for '1'b1'
  // The output port of a Verilog primitive gate cannot be a constant value.
  and u_my_and_gate (1'b1, in1, in2);

endmodule
