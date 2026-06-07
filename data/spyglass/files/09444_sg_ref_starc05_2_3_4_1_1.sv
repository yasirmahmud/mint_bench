module starc05_2_3_4_1_ex1 (input clk, output reg q);
 initial q = 1'b0;
 always @(posedge clk) q <= ~q;
 endmodule
