module curve_wrn_48_module (p1);
  input p1;
  // Added to resolve WRN_240: Input 'p1' declared but not read.
  // This assignment ensures 'p1' is read without adding functional logic.
  wire unused_p1_wire;
  assign unused_p1_wire = p1;
endmodule
