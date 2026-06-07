module curve_stx_ve_600_20260110_225135_attempt4 (
    input clk,
    output reg [7:0] out_data
);

  // First declaration of the parameter 'MY_CONSTANT'.
  parameter MY_CONSTANT = 8;

  // Second declaration of the parameter 'MY_CONSTANT' with the same identifier.
  // This re-declaration directly causes the STX_VE_600 violation, as the name
  // 'MY_CONSTANT' was previously declared on line 6.
  parameter MY_CONSTANT = 16; // STX_VE_600 expected here

  // Minimal logic to use ports and avoid other common violations (e.g., unused inputs/outputs).
  // The parameter 'MY_CONSTANT' is not used in the logic to prevent potential
  // 'illegal use of identifier' (STX_VE_605) or 'ambiguous identifier' warnings.
  always @(posedge clk) begin
    // Simple counter to drive out_data, ensuring 'clk' and 'out_data' are used.
    // An initial value for 'out_data' would typically be in a reset or initial block
    // for functional simulation, but for linting purposes, this usage is sufficient.
    out_data <= out_data + 1;
  end

endmodule
