module curve_synth_5285_20260110_203823_attempt5 (
  input  [3:0] data_in,
  output reg   is_onehot_a,
  output reg   is_onehot_b,
  output [3:0] unused_data_out
);

  // First occurrence of SYNTH_5285: System function '$onehot' is not synthesizable
  always_comb begin
    is_onehot_a = $onehot(data_in);
  end

  // Second occurrence of SYNTH_5285: System function '$onehot' is not synthesizable
  always_comb begin
    is_onehot_b = $onehot(data_in);
  end

  // Synthesizable usage of data_in to prevent W240 (input declared but not read)
  assign unused_data_out = data_in;

endmodule
