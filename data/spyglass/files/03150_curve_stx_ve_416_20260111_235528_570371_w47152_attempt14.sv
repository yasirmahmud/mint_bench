module curve_stx_ve_416_20260111_235528_570371_w47152_attempt14 (
  input wire in_data,
  output reg out_valid_flag
);

  // Internal reg that will be incorrectly used as an input path in the specify block.
  // Named 'internal_clk_like_reg' to align with the rule description's mention of 'clk',
  // and to make it distinct from previous attempts using 'wire' or generic 'reg' names.
  reg internal_clk_like_reg;

  // Simple sequential logic to ensure 'internal_clk_like_reg' is driven and 'in_data' is used.
  // This avoids 'unused signal' warnings for internal_clk_like_reg and in_data.
  always @(posedge in_data) begin
    internal_clk_like_reg <= 1'b1; // Dummy assignment
  end

  // Combinational logic to ensure 'out_valid_flag' is driven and used.
  assign out_valid_flag = internal_clk_like_reg;

  // Specify block to define path delays.
  specify
    // STX_VE_416 violation: 'internal_clk_like_reg' is an internal 'reg',
    // not an input or inout port. Therefore, it is not a valid input-path terminal
    // for a specify block path delay statement.
    (internal_clk_like_reg => out_valid_flag) = 1; // Exactly one STX_VE_416 violation.
  endspecify

endmodule
