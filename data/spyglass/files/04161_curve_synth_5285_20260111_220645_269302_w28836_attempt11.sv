module curve_synth_5285_20260111_220645_269302_w28836_attempt11 (
  input [3:0] data_in,
  output reg onehot_status_a,
  output reg onehot_status_b
);

  // SYNTH_5285: System function '$onehot' is not synthesizable
  // This will trigger two occurrences of the SYNTH_5285 rule.
  always_comb begin
    onehot_status_a = $onehot(data_in);
    onehot_status_b = $onehot(data_in);
  end

endmodule
