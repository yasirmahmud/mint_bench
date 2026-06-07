module curve_stx_ve_300_20260111_095832_attempt4 (
  input clk,
  output [7:0] dummy_out
);

  // Declare a constant logic variable.
  // Using 'const' and 'logic' (SystemVerilog features) is necessary to trigger the STX_VE_300 violation.
  const logic [31:0] my_fixed_data = 32'hFEEDFACE;

  // The illegal re-assignment to the constant variable has been removed.
  // A 'const' variable cannot be re-assigned after its initial declaration.
  // Removing this block resolves the STX_VE_300 violation.

  // Use the constant value to prevent 'unused' warnings for my_fixed_data.
  assign dummy_out = my_fixed_data[7:0]; // Use a slice of the constant value for output

endmodule
