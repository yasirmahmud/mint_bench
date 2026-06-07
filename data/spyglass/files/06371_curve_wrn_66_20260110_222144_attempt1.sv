module curve_wrn_66_20260110_222144_attempt1 (
  output [31:0] out_signal1,
  output [31:0] out_signal2
);

  assign out_signal1 = 0'd0; // Triggers WRN_66 #1
  assign out_signal2 = 0'd0; // Triggers WRN_66 #2

endmodule
