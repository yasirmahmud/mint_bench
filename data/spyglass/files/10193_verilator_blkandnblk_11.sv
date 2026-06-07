module ex11(input clk);
  reg k;
  always @(posedge clk) k = 1'b1; // Blocking in sequential block
  always @(posedge clk) k <= 1'b0;
endmodule
