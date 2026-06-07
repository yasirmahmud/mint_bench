module top_module;
  // Wire to connect to the dummy_output of the submodule instance to resolve W287b.
  wire [31:0] sub_dummy_out;

  // STX_VE_299 violation fixed:
  // 'P' is declared as an integer. The original assignment '{1'b1, 1'b0}' is a 2-bit bit-vector
  // (binary '10', decimal '2'). To ensure compatible type/width, an integer literal '2' is passed.
  sub_module #(.P(2)) inst_sub_1 (
    // The 'dummy_output' port is now present in 'sub_module'.
    // Connecting it to resolve 'W287b' instance output port not connected warning.
    .dummy_output (sub_dummy_out)
  );
endmodule
