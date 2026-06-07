module STARC_3_5_6_3a_ex1 (input clk);
 reg a;
 reg b;
 always @(posedge clk) a <= b;
 endmodule
