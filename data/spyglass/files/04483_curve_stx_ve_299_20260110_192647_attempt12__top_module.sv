module top_module ();
  // Declare a dummy output to connect, preventing unused signal warnings in top_module scope.
  wire top_dummy_out;

  // STX_VE_299 violation: Incompatible connection to parameter 'P'.
  // 'P' is declared as a scalar integer (default 32-bit wide in Verilog-2001).
  // Assigning a concatenation '{1, 2}' creates a 64-bit value (concatenation of two 32-bit values).
  // This constitutes an incompatible connection when assigned to the scalar 32-bit parameter 'P',
  // directly triggering the STX_VE_299 rule as observed in the context examples.
  sub_module #(.P({1, 2})) inst_sub (
    .dummy_out(top_dummy_out)
  );
endmodule
