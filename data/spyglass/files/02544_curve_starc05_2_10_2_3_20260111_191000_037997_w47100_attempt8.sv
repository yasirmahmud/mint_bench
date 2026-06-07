module curve_starc05_2_10_2_3_20260111_191000_037997_w47100_attempt8 (
  input [2:0] data_vector_in,
  output      is_all_zero_out
);

  // STARC05-2.10.2.3: Logical negation used on a vector '(!data_vector_in)'.
  // This rule fires when the logical NOT operator '!' is applied to a multi-bit vector.
  // Verilog evaluates '!data_vector_in' as 1'b1 if all bits in data_vector_in are 0,
  // and 1'b0 otherwise (including X or Z bits).
  assign is_all_zero_out = !data_vector_in;

endmodule
