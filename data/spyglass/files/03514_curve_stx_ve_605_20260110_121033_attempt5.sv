module curve_stx_ve_605_20260110_121033_attempt5 ();

  // Declare a parameter, which is a compile-time constant.
  parameter MY_CONSTANT = 10;

  // FATAL: STX_VE_605 - Illegal use of identifier (MY_CONSTANT).
  // Parameters cannot be assigned to using a continuous assignment.
  assign MY_CONSTANT = 20; 

  // Dummy usage to ensure MY_CONSTANT is not flagged as unused
  // and to ensure dummy_output is not an unused signal.
  wire [7:0] dummy_output;
  assign dummy_output = MY_CONSTANT + 5;

endmodule
