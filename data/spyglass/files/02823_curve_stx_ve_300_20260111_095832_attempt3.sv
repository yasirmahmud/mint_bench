module curve_stx_ve_300_20260111_095832_attempt3 (
  input clk,
  output [7:0] dummy_out
);

  // Declare a constant variable using SystemVerilog 'const' keyword and 'logic' type.
  // These features are necessary to trigger the STX_VE_300 violation.
  const logic [7:0] my_fixed_data = 8'hAA;

  // Attempt to re-assign the constant variable in a synchronous procedural block.
  // This non-blocking assignment is illegal for a 'const' variable and triggers STX_VE_300.
  always @(posedge clk) begin
    my_fixed_data <= 8'h00; // Illegal re-assignment to const variable 'my_fixed_data'
  end

  // Use the constant value to prevent 'unused' warnings for my_fixed_data.
  assign dummy_out = my_fixed_data + 1;

endmodule
