module curve_stx_ve_1188_20260111_113752_attempt9 (
  output wire [31:0] out_val
);

  genvar i; // Declare genvar

  // STX_VE_1188 violation: Invalid context for genvar 'i'.
  // A genvar can only be used inside the generate loop that it indexes.
  // Here, 'i' is declared but no generate loop for 'i' exists.
  // Using 'i' directly in a continuous assignment outside of any generate loop
  // means it has no defined value or valid context, triggering the violation.
  assign out_val = i; // 'i' is used outside of any generate loop it indexes

endmodule
