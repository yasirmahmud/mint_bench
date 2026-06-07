`define MY_MACRO_EX2 8'hAA
module starc05_1_1_4_4_ex2 (input wire clk, input wire rst, output wire [7:0] data_out);
 parameter WIDTH = `MY_MACRO_EX2;
 assign data_out = WIDTH;
 endmodule
