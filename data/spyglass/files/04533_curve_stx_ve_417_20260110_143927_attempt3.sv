module curve_stx_ve_417_20260110_143927_attempt3 (
  input a_in,
  output b_out
);

  // Using 'a_in' to avoid unused signal warnings for input 'a_in'.
  // 'b_out' is driven to avoid unused output warning.
  assign b_out = a_in;

  specify
    // This line triggers STX_VE_417 because 'a_in' is an input port,
    // and 'pulsestyle_onevent' expects an output-path (output or inout port).
    // This specify block is minimal, containing only the violating construct.
    pulsestyle_onevent a_in;
  endspecify

endmodule
