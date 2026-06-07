module my_module_ex1(input [7:0] in_port, output reg [7:0] out_val);
 reg [7:0] in_val;
 initial begin in_val = in_port;
 out_val = in_val++;
 end endmodule
