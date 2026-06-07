module top_mod_ex2;
 wire [3:0] my_signal; // W156: Changed bit ordering from [0:3] to [3:0] to match sub_mod_ex2's 'data_in'.
 sub_mod_ex2 inst_sub (.data_in(my_signal));
 assign my_signal = 4'b0;
 endmodule
