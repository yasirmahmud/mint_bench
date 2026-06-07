module my_module_ex2 (input clk, input rst, output [7:0] out_data);
 reg [7:0] data_reg;
 always @(posedge clk) begin if (rst) data_reg <= 8'b0;
 else data_reg <= 8'hFF;
 end assign data_reg = 8'hAA;
 assign out_data = data_reg;
 endmodule
