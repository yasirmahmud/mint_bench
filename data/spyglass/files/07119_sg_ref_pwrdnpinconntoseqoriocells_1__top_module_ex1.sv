module top_module_ex1 (input clk, input rst, input data_in, output data_out);
 wire pwr_down_signal;
 assign pwr_down_signal = data_in & rst;
 my_cell u_my_cell (.in_data(data_in), .PWRDN(pwr_down_signal), .out_data(data_out));
 endmodule
