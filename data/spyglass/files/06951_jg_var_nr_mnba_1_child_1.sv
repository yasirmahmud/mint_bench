module multiple_nba_1 (
  input clk,
  input rst_n,
  input a,
  input b,
  output reg out_reg
);

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    out_reg <= 1'b0;
  end else begin
    // Resolving multiple non-blocking assignments to 'out_reg'.
    // In the original code, 'out_reg <= b;' would implicitly override 'out_reg <= a;'
    // due to the non-blocking nature and textual order. To preserve this effective behavior
    // and resolve the violation, only the assignment to 'b' is kept.
    out_reg <= b;
  end
end

endmodule
