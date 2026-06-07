module starc05_2_10_3_1_ex2(input [3:0] a, input [4:0] b, output reg out);
 always @(*) begin if (a == a+b) out = 1;
 else out = 0;
 end endmodule
