module curve_synth_5235_20260110_154936_attempt4 (
  input [7:0] in_data_a,
  input [7:0] in_data_b,
  output [7:0] out_result_a,
  output [7:0] out_result_b
);

  // Define a localparam with a value of zero, which will act as a static zero divisor.
  localparam [7:0] ZERO_DIVISOR = 8'd0;

  // Perform a division operation. Division by a statically defined zero is illegal
  // and is expected to trigger the first SYNTH_5235 violation.
  assign out_result_a = in_data_a / ZERO_DIVISOR;

  // Perform a modulus operation. Modulus by a statically defined zero is also illegal
  // and is expected to trigger the second SYNTH_5235 violation.
  assign out_result_b = in_data_b % ZERO_DIVISOR;

endmodule
