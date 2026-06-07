module curve_synth_5411_20260110_133219_attempt5 (
  input wire [3:0] in_vec,
  output wire [3:0] out_data
);

  // Target rule: SYNTH_5411 - Zero or negative repetition multiplier found in concatenation expression
  // The expression {0{in_vec}} uses a zero repetition multiplier.
  // This directly reproduces the scenario from the provided context example, which confirmed SYNTH_5411 triggering.
  assign out_data = {0{in_vec}};

endmodule
