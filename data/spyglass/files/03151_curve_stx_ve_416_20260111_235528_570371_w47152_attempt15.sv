module curve_stx_ve_416_20260111_235528_570371_w47152_attempt15 (
  input wire global_clk,
  input wire reset_n,
  output reg output_valid
);

  // An internal register that acts like a clock or a control signal,
  // but is not an actual input port. This is the signal that will cause the violation.
  reg internal_clk_like_signal;

  // Simple sequential logic to ensure internal_clk_like_signal is driven
  // and its inputs (global_clk, reset_n) are used, avoiding unused signal warnings.
  always @(posedge global_clk or negedge reset_n) begin
    if (!reset_n) begin
      internal_clk_like_signal <= 1'b0;
    end else begin
      internal_clk_like_signal <= ~internal_clk_like_signal; // Toggles on each clock edge
    end
  end

  // Drive the output port using the internal signal.
  // This ensures 'output_valid' is used and driven, avoiding unused signal warnings.
  assign output_valid = internal_clk_like_signal;

  specify
    // STX_VE_416 violation: 'internal_clk_like_signal' is an internal 'reg',
    // not an input or inout port. Therefore, it is not a valid input-path terminal
    // for a specify block path delay statement.
    (internal_clk_like_signal => output_valid) = 1; // This line triggers STX_VE_416.
  endspecify

endmodule
