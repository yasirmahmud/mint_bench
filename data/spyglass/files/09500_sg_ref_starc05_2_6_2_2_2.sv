module star_ex2_module (input clk, input rst, input in_data, output reg out_data);
 reg my_reg;
 always @(posedge clk or posedge rst or my_reg) begin if (rst) begin my_reg <= 1'b0;
 out_data <= 1'b0;
 end else begin my_reg <= in_data;
 out_data <= my_reg;
 end end endmodule
