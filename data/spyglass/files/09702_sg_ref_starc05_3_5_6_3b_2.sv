module my_module_ex2 (input wire clk, output reg [7:0] data);
 wire enable;
 reg [3:0] count;
 parameter WIDTH = 8;
 assign data = {WIDTH{1'b0}};
 endmodule
