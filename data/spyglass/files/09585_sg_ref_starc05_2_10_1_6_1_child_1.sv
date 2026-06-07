module starc05_2_10_1_6_ex1;
 wire [3:0] my_signal;
 assign my_signal = 4'b1001;
 wire [3:0] dummy_signal_to_read;
 assign dummy_signal_to_read = my_signal;
 endmodule
