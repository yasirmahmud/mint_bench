module ex6;
  reg f;
  always @* f = 1'b1;
  always @(posedge clk) f <= 1'b0;
endmodule
