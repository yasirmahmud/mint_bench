module curve_wrn_40_attempt11;
  reg [7:0] my_duplicate_signal_a;
  wire [7:0] my_duplicate_signal_a; // Triggers WRN_40: 'my_duplicate_signal_a' previously declared
endmodule
