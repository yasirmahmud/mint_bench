module curve_starc05_2_1_4_5_20260111_102451_attempt5 (
  input [3:0] input_data_bus,
  input [2:0] enable_ctrl,
  output output_valid
);

  assign output_valid = input_data_bus && enable_ctrl;

endmodule
