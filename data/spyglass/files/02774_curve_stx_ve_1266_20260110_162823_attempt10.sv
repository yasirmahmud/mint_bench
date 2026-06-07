package my_distinct_package;
  // STX_VE_1266: Implicit continuous assignment is not allowed within a package.
  // This line declares a wire with an implicit continuous assignment inside a package,
  // directly violating the STX_VE_1266 rule.
  wire [3:0] package_signal_a = 4'hF;
endpackage

module curve_stx_ve_1266_20260110_162823_attempt10 ();
  // Empty module to avoid triggering other rules.
endmodule
