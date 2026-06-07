module curve_w317_20260111_002707_attempt5 ();
  supply0 internal_gnd;

  // This assignment to a supply net should trigger W317
  assign internal_gnd = 1'b0;

endmodule
