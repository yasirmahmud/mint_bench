module curve_synth_115_20260111_175005_818022_w53504_attempt6 (
  output out1,
  output out2
);

  // SYNTH_115 violation: Declaration of TRI1 net type is not synthesizable.
  tri1 net_a;
  // SYNTH_115 violation: Declaration of TRI1 net type is not synthesizable.
  tri1 net_b;

  // Assigning to outputs to avoid unused signal warnings/violations.
  assign out1 = net_a;
  assign out2 = net_b;

endmodule
