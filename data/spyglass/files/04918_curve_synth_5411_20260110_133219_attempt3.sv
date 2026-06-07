module curve_synth_5411_20260110_133219_attempt3 (
  input wire [3:0] in_vec,
  output wire out_data
);

  // SYNTH_5411: Zero or negative repetition multiplier found in concatenation expression
  assign out_data = {0{in_vec}};

endmodule
