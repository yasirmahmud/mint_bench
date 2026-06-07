module top_ex1;
 wire actual_signal_name;
 wire my_clock;
 sub_mod u_sub (.formal_data_in(actual_signal_name), .clk_i(my_clock));
 assign actual_signal_name = 1'b0;
 assign my_clock = 1'b0;
 endmodule
