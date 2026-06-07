module SignedKeywordUsage_ex2;
 reg signed [7:0] my_signal;
 initial begin my_signal = 8'sd10;
 $display("my_signal = %d", my_signal);
 end endmodule
