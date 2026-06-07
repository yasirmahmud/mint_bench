module top_mod_ex1;
 reg [7:0] my_signal;
 initial my_signal = 8'hAA;
 sub_mod inst1 (.data_in (my_signal[3:0]));
 endmodule
