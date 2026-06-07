module curve_starc05_2_1_4_5_20260111_102451_attempt4 (
  input [1:0] ctrl_signal,
  input [1:0] data_valid,
  output output_flag
);

  assign output_flag = ctrl_signal && data_valid;

endmodule
