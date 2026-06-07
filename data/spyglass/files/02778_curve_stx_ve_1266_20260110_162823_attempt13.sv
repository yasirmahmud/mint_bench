package my_package_stx_ve_1266_ex5;
  // STX_VE_1266: Implicit continuous assignment is not allowed within package.
  // This line declares a 4-bit wire with an implicit continuous assignment directly inside a package,
  // triggering the STX_VE_1266 rule. This is example #5, distinct from previous attempts by using a different variable name, width, and value.
  wire [3:0] enable_signal = 4'hF;
endpackage

module curve_stx_ve_1266_20260110_162823_attempt13 ();
  // An empty module to ensure no other rules are triggered.
  // The violation is intentionally placed within the package block as required by STX_VE_1266.
endmodule
