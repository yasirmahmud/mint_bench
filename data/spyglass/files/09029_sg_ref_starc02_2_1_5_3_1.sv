module starc02_2_1_5_3_ex1(input [1:0] cond, output reg out);
 always @(*) if (cond) out = 1'b1;
 else out = 1'b0;
 endmodule
