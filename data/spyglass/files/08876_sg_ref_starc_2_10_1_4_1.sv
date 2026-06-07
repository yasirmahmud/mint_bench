module starc_2_10_1_4_ex1(input in_a, output reg out_q);
 always @(*) begin if (in_a == 1'bx) out_q = 1'b1;
 else out_q = 1'b0;
 end endmodule
