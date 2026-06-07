module curve_stx_ve_1188_20260111_113752_attempt8 (
  input wire [7:0] data_in,
  output wire result
);

  genvar i; // Declare genvar

  // STX_VE_1188 violation: Invalid context for genvar 'i'.
  // A genvar 'i' is a compile-time construct whose value is defined only within the generate loop it indexes.
  // Using 'i' to define a localparam outside of any generate loop means it has no defined value or valid context.
  localparam MY_CONSTANT = i; // 'i' is used outside a generate loop it indexes

  assign result = data_in[0] & MY_CONSTANT[0]; // Use the signals to avoid unused warnings

endmodule
