module DifferAlways_ML_ex2 (input clk, input rst, input [7:0] in_val, output reg [7:0] out_val);
 reg [7:0] my_reg;
 always @(posedge clk or posedge rst) begin if (rst) begin my_reg = 8'd0;
 end else begin my_reg <= in_val;
 end end assign out_val = my_reg;
 endmodule
