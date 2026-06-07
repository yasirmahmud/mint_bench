module curve_stx_ve_605_20260110_121033_attempt5 ();

  // Declare a parameter, which is a compile-time constant.
  parameter MY_CONSTANT = 10;

  // The illegal continuous assignment to a parameter has been removed.
  // Parameters are compile-time constants and cannot be assigned to at run-time.

  // Dummy usage to ensure MY_CONSTANT is not flagged as unused
  // and to ensure dummy_output is not an unused signal.
  wire [7:0] dummy_output;
  assign dummy_output = MY_CONSTANT + 5;

endmodule
