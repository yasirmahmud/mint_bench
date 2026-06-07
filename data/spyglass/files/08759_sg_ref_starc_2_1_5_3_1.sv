module STARC_2_1_5_3_ex1 (input [1:0] sel, output reg out);
 always @(*) begin if (sel) out = 1'b1;
 else out = 1'b0;
 end endmodule
