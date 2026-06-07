module STARC02_2_10_1_3_ex2(input [1:0] a, output reg b);
 always @(*) if (a == 2'bx) b = 1'b1;
 else b = 1'b0;
 endmodule
