module top_module;
  // Instance 1: Assigning an aggregate value '{1, 2}' to a scalar parameter P
  // This triggers STX_VE_299.
  sub_module #(.P('{1, 2})) inst_sub_1 ();

  // Instance 2: Assigning an aggregate value '{3, 4}' to a scalar parameter P
  // This triggers a second STX_VE_299 violation.
  sub_module #(.P('{3, 4})) inst_sub_2 ();
endmodule
