module curve_synth_5285_20260112_004352_522857_w6680_attempt16 (
  input [3:0] data_in,
  output reg out_onehot_full,
  output reg out_onehot_slice,
  output synthesizable_dummy_out
);

  // To prevent W240 (unused input) seen in previous attempts,
  // 'data_in' is explicitly used in a synthesizable 'assign' statement.
  assign synthesizable_dummy_out = |data_in;

  // Using 'always @*' (Verilog-2001 sensitivity list) for procedural assignments.
  always @* begin
    // SYNTH_5285 violation for $onehot (occurrence 1)
    // System function '$onehot' is not synthesizable
    out_onehot_full = $onehot(data_in);

    // SYNTH_5285 violation for $onehot (occurrence 2)
    // Using a slice of the input for the second occurrence to ensure distinctness
    // System function '$onehot' is not synthesizable
    out_onehot_slice = $onehot(data_in[2:0]);
  end

endmodule
