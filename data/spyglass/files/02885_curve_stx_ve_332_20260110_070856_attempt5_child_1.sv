module curve_stx_ve_332_20260110_070856_attempt5 (
  input in1,
  input in2
);

  // Declare an internal wire to connect to the output of the 'nand' gate.
  // This resolves the STX_VE_332 violation where a constant was used as an output port.
  wire nand_gate_out;
  nand u_nand (nand_gate_out, in1, in2);

endmodule
