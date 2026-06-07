module STARC05_2_5_1_2_ex2 (input in_data, input sel1, input sel2, output out_data);
 wire enable_signal;
 assign enable_signal = sel1 & sel2;
 assign out_data = enable_signal ? in_data : 1'bz;
 endmodule
