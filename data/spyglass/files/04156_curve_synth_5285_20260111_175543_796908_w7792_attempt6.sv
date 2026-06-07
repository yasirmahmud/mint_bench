module curve_synth_5285_20260111_175543_796908_w7792_attempt6 (
  input wire [1:0] in_sig_a,
  input wire [2:0] in_sig_b,
  output wire out_sig_a,
  output wire out_sig_b
);

  assign out_sig_a = $onehot(in_sig_a);
  assign out_sig_b = $onehot(in_sig_b);

endmodule
