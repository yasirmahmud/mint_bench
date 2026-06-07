module rule_43_ex1 (input clk, input rst, input [7:0] data_in, output [7:0] data_out);
 wire efuse_signal;
 my_memory_cell mem_inst (.clk(clk), .rst(rst), .data_in(data_in), .EFUSE(efuse_signal), .data_out(data_out));
 assign efuse_signal = 1'b1;
 endmodule
