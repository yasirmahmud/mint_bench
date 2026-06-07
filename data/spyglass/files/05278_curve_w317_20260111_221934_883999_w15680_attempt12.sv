module curve_w317_20260111_221934_883999_w15680_attempt12;
  // Declare four distinct supply0 nets
  supply0 ground_net_a, ground_net_b, ground_net_c, ground_net_d;

  // Each assignment to a supply net will trigger a W317 violation.
  // This module is designed to generate exactly 4 W317 violations, matching the 'Total occurrences'.
  // All assignments provide the 'correct' value for a supply0 net, yet still trigger W317 because any assignment to a supply net is an error.
  assign ground_net_a = 1'b0; // W317: Assigning to a supply0 net
  assign ground_net_b = 1'b0; // W317: Assigning to a supply0 net
  assign ground_net_c = 1'b0; // W317: Assigning to a supply0 net
  assign ground_net_d = 1'b0; // W317: Assigning to a supply0 net

endmodule
