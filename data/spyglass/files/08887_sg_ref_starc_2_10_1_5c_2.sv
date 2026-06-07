module star_2_10_1_5c_ex2 (input sel, output reg out_reg);
 always @(*) begin case (sel) 1'b0: out_reg = 1'b0;
 1'b1: out_reg = 1'bx;
 endcase end endmodule
