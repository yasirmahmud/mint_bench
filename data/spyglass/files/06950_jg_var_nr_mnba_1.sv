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
    out_reg <= a;
    out_reg <= b;
  end
end

endmodule
