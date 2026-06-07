module curve_starc05_2_3_1_5b_20260111_222307_982273_w49296_attempt11 (
  input wire i_data_a,
  input wire i_data_b,
  output wire o_result_1,
  output wire o_result_2,
  output wire o_result_3,
  output wire o_result_4,
  output wire o_result_5
);

  // STARC05-2.3.1.5b: Negative delay value '(-1)' used
  assign #(-1) o_result_1 = i_data_a;
  assign #(-1) o_result_2 = i_data_b;
  assign #(-1) o_result_3 = i_data_a & i_data_b;
  assign #(-1) o_result_4 = i_data_a | i_data_b;
  assign #(-1) o_result_5 = ~i_data_a;

endmodule
