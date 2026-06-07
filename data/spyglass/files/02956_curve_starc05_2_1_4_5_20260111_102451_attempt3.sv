module curve_starc05_2_1_4_5_20260111_102451_attempt3 (
  input [4:0] request_vec,
  input [5:0] config_data,
  output enable_signal
);

assign enable_signal = request_vec && config_data;

endmodule
