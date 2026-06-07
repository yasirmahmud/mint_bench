module star_c02_2_1_5_3_ex2 (input [1:0] condition_in, output reg out_reg);
 always @(*) begin if (condition_in) out_reg = 1'b1;
 else out_reg = 1'b0;
 end endmodule
