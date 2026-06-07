module ReportCppKeyWords_ML_ex1 (in_signal);
 input in_signal;
 wire unused_in_signal_read; // Declare a dummy wire to read the input
 assign unused_in_signal_read = in_signal; // Read the input signal to resolve W240
 endmodule
