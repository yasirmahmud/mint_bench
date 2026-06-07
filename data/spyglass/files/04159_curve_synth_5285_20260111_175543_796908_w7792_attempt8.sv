module curve_synth_5285_20260111_175543_796908_w7792_attempt8 (
  input wire [1:0] in_vec,
  output wire is_onehot_status
);

  assign is_onehot_status = $onehot(in_vec);

endmodule
