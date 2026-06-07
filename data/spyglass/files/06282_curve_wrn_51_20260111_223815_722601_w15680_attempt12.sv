module curve_wrn_51_20260111_223815_722601_w15680_attempt12 (
  input [7:0] data_a,
  input [7:0] data_b,
  output [47:0] final_output
);

  // WRN_51: The unsized number '100' in the concatenation triggers the violation.
  // 'data_a' (8 bits) + '100' (32 bits default) + 'data_b' (8 bits) = 48 bits.
  // 'final_output' is explicitly sized to 48 bits to prevent width mismatch warnings.
  assign final_output = {data_a, 100, data_b};

endmodule
