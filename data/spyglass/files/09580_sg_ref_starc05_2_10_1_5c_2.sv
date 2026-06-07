module star_c05_2_10_1_5c_ex2 (input clk, input rst, output reg out_reg);
 always @(posedge clk or posedge rst) begin if (rst) begin out_reg <= 1'b0;
 end else begin out_reg <= 1'bx;
 end end endmodule
