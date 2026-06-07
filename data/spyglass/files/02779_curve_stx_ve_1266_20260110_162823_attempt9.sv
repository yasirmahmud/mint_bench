package my_package;
  // STX_VE_1266: Implicit continuous assignment is not allowed within a package.
  // This line declares a wire with an implicit continuous assignment inside a package,
  // directly violating the STX_VE_1266 rule.
  wire [7:0] data_in_package = 8'hAB;
endpackage

module curve_stx_ve_1266_20260110_162823_attempt9 (
  // Empty module to avoid triggering other rules
);
  // No internal logic or ports needed for this specific violation.
endmodule
