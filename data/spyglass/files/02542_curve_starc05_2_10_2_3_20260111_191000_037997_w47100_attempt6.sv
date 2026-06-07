module curve_starc05_2_10_2_3_20260111_191000_037997_w47100_attempt6 (
  input [3:0] data_vector,
  output result_flag
);

  assign result_flag = !data_vector; // STARC05-2.10.2.3: Logical negation used on a vector

endmodule
