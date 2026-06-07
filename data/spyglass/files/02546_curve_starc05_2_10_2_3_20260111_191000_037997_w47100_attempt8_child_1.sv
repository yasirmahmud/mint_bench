module curve_starc05_2_10_2_3_20260111_191000_037997_w47100_attempt8 (
  input [2:0] data_vector_in,
  output      is_all_zero_out
);

  // To resolve STARC05-2.1.4.5 and STARC05-2.10.2.3 and preserve the described behavior,
  // replace '!data_vector_in' with '(data_vector_in === 3'b000)'.
  // The '===' (case equality) operator compares all bits including X and Z,
  // matching the specified behavior of evaluating to 1'b0 when X or Z bits are present.
  assign is_all_zero_out = (data_vector_in === 3'b000);

endmodule
