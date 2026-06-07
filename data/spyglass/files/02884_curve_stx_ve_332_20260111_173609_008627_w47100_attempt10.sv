module curve_stx_ve_332_20260111_173609_008627_w47100_attempt10 (
  input a,
  input b
);

  // STX_VE_332: Gate 'and' has invalid output specification for '1'b1'
  // The output port of a Verilog primitive gate cannot be a constant value.
  and my_and_inst (1'b1, a, b);

endmodule
