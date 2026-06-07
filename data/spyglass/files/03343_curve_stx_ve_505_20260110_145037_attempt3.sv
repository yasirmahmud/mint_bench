module curve_stx_ve_505_20260110_145037_attempt3();

  // STX_VE_505: Compiler Directive (`end_keywords) can only be specified outside a design element.
  // This example demonstrates two occurrences of the violation in different contexts within the module.

  wire my_data;
  assign my_data = 1'b1; // Simple assignment to ensure 'my_data' is not unused

  initial begin
    // Placing `end_keywords inside an initial block still violates STX_VE_505
    `end_keywords // Expected to trigger STX_VE_505 (1st occurrence)
  end

  // Placing `end_keywords directly in the module body after other elements also violates STX_VE_505
  `end_keywords // Expected to trigger STX_VE_505 (2nd occurrence)

endmodule
