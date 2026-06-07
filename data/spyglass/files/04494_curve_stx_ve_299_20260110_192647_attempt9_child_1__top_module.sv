module top_module;
  // STX_VE_299 violation fixed:
  // 'P' is declared as an integer. The original assignment '{1'b1, 1'b0}' is a 2-bit bit-vector
  // (binary '10', decimal '2'). To ensure compatible type/width, an integer literal '2' is passed.
  sub_module #(.P(2)) inst_sub_1 (
    // The 'dummy_output' port is now present in 'sub_module'.
    // Leaving it unconnected here is acceptable if no 'unconnected port' warning is listed.
    // If such a warning were present, a dummy wire would be needed in top_module to connect it.
  );
endmodule
