module ex2(input clk);
  reg b;
  always @(posedge clk) begin
    b <= 1'b1;
  end
  always @* begin
    b = 1'b0;
  end
endmodule
