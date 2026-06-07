module my_module_ex2 (input clk, input rst, output [WIDTH-1:0] data_out);
 parameter WIDTH = 8;
 reg [WIDTH-1:0] data_reg;
 always @(posedge clk or posedge rst) begin if (rst) data_reg <= 0;
 else data_reg <= data_reg + 1;
 end assign data_out = data_reg;
 endmodule
