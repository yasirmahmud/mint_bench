module curve_starc05_2_1_4_5_20260111_102451_attempt2 (
  input [2:0] data_in_A,
  input [2:0] ctrl_B,
  output result_out
);

assign result_out = data_in_A && ctrl_B;

endmodule
