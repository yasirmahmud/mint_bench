module starc_2_10_2_3_ex1(input [7:0] a, output reg b);
 always @(*) b = !a;
 endmodule
