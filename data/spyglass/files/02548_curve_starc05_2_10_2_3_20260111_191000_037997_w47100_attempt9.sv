module curve_starc05_2_10_2_3_20260111_191000_037997_w47100_attempt9 (
  input [2:0] data_vector_in,
  input       enable_in,
  output      final_condition_out
);

  // STARC05-2.10.2.3: Logical negation used on a vector '(!data_vector_in)'.
  // This rule fires when the logical NOT operator '!' is applied to a multi-bit vector.
  // The expression '(!data_vector_in) && enable_in' resolves to a 1-bit result.
  // This example attempts to isolate STARC05-2.10.2.3 by embedding the logical negation
  // within a larger logical expression where a direct bit-wise replacement ('~data_vector_in')
  // would fundamentally change the functional behavior of the expression.
  // Specifically, '(!data_vector_in)' evaluates to true if data_vector_in is all zeros,
  // whereas '(|(~data_vector_in))' (which is how '&&' would operate on a multi-bit '~data_vector_in')
  // evaluates to true if data_vector_in is NOT all ones. These are distinct conditions.
  // This functional difference is intended to prevent the companion rule STARC05-2.1.4.5
  // ("Use bit-wise operator instead of logical operator '!'") from firing, if the analysis
  // tool is smart enough to detect non-equivalence for replacement suggestions.
  assign final_condition_out = (!data_vector_in) && enable_in;

endmodule
