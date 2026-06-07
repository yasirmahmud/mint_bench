module curve_stx_ve_1188_20260111_113752_attempt11 (
  input wire in_sig,
  output wire out_sig
);

  genvar i; // Declare genvar 'i'

  // STX_VE_1188 violation: Invalid context for genvar 'i'.
  // A genvar is a compile-time loop variable for generate blocks.
  // It cannot be used as an operand in a continuous assignment or
  // any other run-time expression, as it does not represent a signal.
  assign out_sig = in_sig & i; // Expected violation here

endmodule
