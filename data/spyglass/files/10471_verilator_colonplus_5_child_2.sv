module test5 (
  output logic [15:0] temp_vec
);
  // The 'initial' block is ignored during synthesis (SYNTH_5143 violation).
  // In the original design, 'long_vec' was initialized to '0' in the initial block
  // and never driven by any other synthesizable logic. This means 'long_vec'
  // effectively behaves as a constant 0 throughout simulation, and would be an
  // undriven net for synthesis, often implying 0 depending on the tool.
  // To resolve the synthesis warning and preserve the functional behavior
  // (where temp_vec is a slice of an all-zero vector), 'long_vec' can be
  // replaced with a constant 64'b0.

  always @* begin
    temp_vec = 64'b0[32 +: 16]; // Slice of a constant zero vector
  end
endmodule
