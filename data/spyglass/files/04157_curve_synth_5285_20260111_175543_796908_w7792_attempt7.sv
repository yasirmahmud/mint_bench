module curve_synth_5285_20260111_175543_796908_w7792_attempt7 (
  input wire [3:0] in_data,
  output wire out_onehot_status,
  output wire [3:0] out_data_copy
);

  assign out_onehot_status = $onehot(in_data);
  assign out_data_copy = in_data;

endmodule
