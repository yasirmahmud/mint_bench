module curve_stx_ve_417_20260110_193730_attempt6 (
  input in_a,
  input in_b,
  output out_c
);

  // Use inputs in a simple combinational assignment
  assign out_c = in_a & in_b;

  specify
    // Violation 1: in_a is an input, which is not a valid output-path for pulsestyle directives
    pulsestyle_onevent in_a;

    // Violation 2: in_b is an input, which is not a valid output-path for pulsestyle directives
    pulsestyle_ondetect in_b;
  endspecify

endmodule
