module curve_w415_20260111_154018_082911_w11684_attempt5 (
  input wire in_a,
  input wire in_b,
  output wire out_c
);

  wire target_signal; // Declare a wire that will have multiple drivers

  // The first continuous assignment drives 'target_signal'
  assign target_signal = in_a;

  // The second continuous assignment also drives 'target_signal'.
  // This creates a multiple simultaneous driver violation (W415)
  // as 'target_signal' is a 'wire' and cannot be driven by two
  // separate 'assign' statements simultaneously.
  assign target_signal = in_b;

  // Connect the multiply-driven signal to an output to ensure it's used
  assign out_c = target_signal;

endmodule
