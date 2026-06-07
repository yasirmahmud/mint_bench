package my_package_stx_ve_1266_ex4;
  // STX_VE_1266: Implicit continuous assignment is not allowed within package.
  // This line declares a 1-bit wire with an implicit continuous assignment directly inside a package,
  // triggering the STX_VE_1266 rule. This is example #4, distinct from previous attempts by using a different variable name and width.
  wire flag_active = 1'b1;
endpackage

module curve_stx_ve_1266_20260110_162823_attempt12 ();
  // An empty module to ensure no other rules are triggered.
  // The violation is intentionally placed within the package block as required by STX_VE_1266.
endmodule
