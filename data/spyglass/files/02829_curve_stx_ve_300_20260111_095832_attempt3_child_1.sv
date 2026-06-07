module curve_stx_ve_300_20260111_095832_attempt3 (
  input clk,
  output [7:0] dummy_out
);

  // Declare a constant variable using SystemVerilog 'const' keyword and 'logic' type.
  // These features are necessary to trigger the STX_VE_300 violation.
  const logic [7:0] my_fixed_data = 8'hAA;

  // The illegal re-assignment to 'my_fixed_data' has been removed.
  // A 'const' variable cannot be re-assigned after its initial declaration.
  // Removing the illegal assignment preserves the intended functional behavior
  // where 'my_fixed_data' remains its initialized constant value.

  // Use the constant value to prevent 'unused' warnings for my_fixed_data.
  assign dummy_out = my_fixed_data + 1;

endmodule
