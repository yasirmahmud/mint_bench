module W280_ex1(input clk);
 reg a, b;
 always @(posedge clk) a <= #1 b;
 endmodule
