module curve_stx_ve_332_20260111_214334_327922_w28836_attempt11 (
  input in_a,
  input in_b
);

  // STX_VE_332: Gate 'nand' has invalid output specification for '1'b1'
  // The output port of a Verilog primitive gate cannot be a constant value.
  wire nand_out;
  nand u_nand_gate (nand_out, in_a, in_b);

endmodule
