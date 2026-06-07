module STARC05_2_1_5_3_ex1;
 reg [1:0] condition_reg;
 reg out_reg;
 always @(*) begin if (condition_reg) begin out_reg = 1'b1;
 end else begin out_reg = 1'b0;
 end end endmodule
