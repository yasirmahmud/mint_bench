module ex16(input clk);
  reg p;
  always @(posedge clk) begin
    p = 1'b1;
  end
  always @(negedge clk) begin
    p <= 1'b0;
  end
endmodule
