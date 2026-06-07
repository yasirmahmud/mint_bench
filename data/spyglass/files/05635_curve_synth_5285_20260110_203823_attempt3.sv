module curve_synth_5285_20260110_203823_attempt3 (
  input  [1:0] in_vec,
  input        single_bit,
  output       out_hot_status,
  output       out_hot0_status
);

  reg out_hot_status;
  reg out_hot0_status;

  // First occurrence of SYNTH_5285 (using $onehot)
  always @* begin
    out_hot_status = $onehot(in_vec);
  end

  // Second occurrence of SYNTH_5285 (using $onehot0)
  always @* begin
    out_hot0_status = $onehot0(single_bit);
  end

endmodule
