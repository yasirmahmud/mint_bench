module curve_synth_5058_20260111_000450_attempt5 (
  input wire        single_bit_in_a,
  input wire [1:0]  multi_bit_in_b,
  input wire        single_bit_in_c,
  input wire [2:0]  multi_bit_in_d,

  output wire     match_out_1,
  output wire     match_out_2,
  output wire     match_out_3,
  output wire     match_out_4
);

  // Instance 1 of SYNTH_5058: Comparing a single-bit input with a single-bit literal.
  // This instance is distinct from previous attempts by using different input names and specific literal values.
  assign match_out_1 = (single_bit_in_a === 1'b1);

  // Instance 2 of SYNTH_5058: Comparing a multi-bit input with a multi-bit literal.
  // This instance provides distinctness by using a multi-bit comparison.
  assign match_out_2 = (multi_bit_in_b === 2'b10);

  // Instance 3 of SYNTH_5058: Comparing two single-bit inputs (wire-to-wire comparison).
  // This is distinct as it compares two wires directly, rather than a wire to a literal.
  assign match_out_3 = (single_bit_in_c === single_bit_in_a);

  // Instance 4 of SYNTH_5058: Comparing a different multi-bit input (3-bit) with a distinct multi-bit literal.
  // This instance is distinct by using a different bit-width for the input and a different literal value.
  assign match_out_4 = (multi_bit_in_d === 3'b011);

endmodule
