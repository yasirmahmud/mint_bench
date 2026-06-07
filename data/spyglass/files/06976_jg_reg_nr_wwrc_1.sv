module multiple_writers_ex1 (
  input clk,
  input rst_n,
  input in_a,
  input in_b,
  output reg out_reg
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_reg <= 1'b0;
    end else begin
      out_reg <= in_a;
    end
  end

  always @(posedge clk) begin
    out_reg <= in_b;
  end

endmodule
