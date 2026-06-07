module top_mod_ex2;
 wire [0:3] my_signal;
 sub_mod_ex2 inst_sub (.data_in(my_signal));
 assign my_signal = 4'b0;
 endmodule
