module curve_stx_ve_417_20260110_143927_attempt4 (
  input a_in,
  output b_out
);

  // Drive output and use input to prevent unused signal/port warnings.
  assign b_out = a_in;

  specify
    // This line triggers STX_VE_417 because 'a_in' is an input port,
    // but 'pulsestyle_onevent' expects an output-path (an output or inout port).
    pulsestyle_onevent a_in;
  endspecify

endmodule
