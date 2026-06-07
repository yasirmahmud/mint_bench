module tie_input_to_supply1 (
  input wire control_in,
  output wire status_out
);
  // The original line 'assign control_in = supply1;' caused a syntax error (STX_VE_481)
  // because 'supply1' is an illegal literal for assignment and an input port cannot be driven internally.
  // To resolve the violation and preserve the implied functional behavior (outputting a constant high),
  // we directly assign a logic '1' (1'b1) to the 'status_out' port.
  // The 'control_in' input port remains, but is now unused.
  assign status_out = 1'b1;
endmodule
