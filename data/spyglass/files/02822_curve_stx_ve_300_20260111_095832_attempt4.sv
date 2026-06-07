module curve_stx_ve_300_20260111_095832_attempt4 (
  input clk,
  output [7:0] dummy_out
);

  // Declare a constant logic variable.
  // Using 'const' and 'logic' (SystemVerilog features) is necessary to trigger the STX_VE_300 violation.
  const logic [31:0] my_fixed_data = 32'hFEEDFACE;

  // Attempt to re-assign the constant variable in a negative-edge triggered synchronous procedural block.
  // This blocking assignment is illegal for a 'const' variable and triggers STX_VE_300.
  always @(negedge clk) begin
    my_fixed_data = 32'hDEADBEEF; // Illegal re-assignment to const variable 'my_fixed_data'
  end

  // Use the constant value to prevent 'unused' warnings for my_fixed_data.
  assign dummy_out = my_fixed_data[7:0]; // Use a slice of the constant value for output

endmodule
