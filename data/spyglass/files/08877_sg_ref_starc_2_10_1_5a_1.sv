module starc_2_10_1_5a_ex1(input [1:0] a, output reg out);
 always @* if(a == 2'b1x) out = 1;
 else out = 0;
 endmodule
