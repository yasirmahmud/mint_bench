module ClockStyle_ex2 (input clk, input d, output reg q);
 always @(clk) if (clk == 1'b1) q <= d;
 endmodule
