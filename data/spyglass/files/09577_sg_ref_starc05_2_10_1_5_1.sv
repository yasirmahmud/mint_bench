module starc05_2_10_1_5_ex1(input [3:0] in_a, output reg out_b);
 always @(*) begin if (in_a == 4'b101x) out_b = 1'b1;
 else out_b = 1'b0;
 end endmodule
