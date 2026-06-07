module curve_w317_20260111_221934_883999_w15680_attempt11;
  // Declare four distinct supply nets
  supply0 my_gnd_net_a;
  supply1 my_vcc_net_b;
  supply0 my_gnd_net_c;
  supply1 my_vcc_net_d;

  // Each assignment to a supply net will trigger a W317 violation.
  // This module generates exactly 4 W317 violations, as requested.
  assign my_gnd_net_a = 1'b0; // W317: Assignment to supply0 net
  assign my_vcc_net_b = 1'b1; // W317: Assignment to supply1 net
  assign my_gnd_net_c = 1'b1; // W317: Assignment to supply0 net (even with value mismatch)
  assign my_vcc_net_d = 1'b0; // W317: Assignment to supply1 net (even with value mismatch)

endmodule
