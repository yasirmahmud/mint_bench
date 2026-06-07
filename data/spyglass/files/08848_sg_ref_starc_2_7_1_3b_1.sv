module star_2_7_1_3b_ex1 (clk, rst, in_data, out_reg);
 input clk, rst, in_data;
 output reg out_reg;
 always @(posedge clk) begin if (rst) out_reg <= 1'b0;
 end endmodule
