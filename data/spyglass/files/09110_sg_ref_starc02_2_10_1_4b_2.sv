module stac02_2_10_1_4b_ex2 (input [3:0] in_sig, output reg out_reg);
 initial begin if (in_sig == 4'b10x1) out_reg = 1'b1;
 else out_reg = 1'b0;
 end endmodule
