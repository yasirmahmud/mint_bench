module curve_wrn_27_20260110_213804_attempt6 (
  input wire [3:0] data_in,
  output wire out_bit_0,
  output wire out_bit_1
);

  // Trigger WRN_27 twice by attempting to access bits outside the declared range of 'data_in'.
  // 'data_in' is declared as [3:0], so indices 4 and 5 are out of range.
  assign out_bit_0 = data_in[4]; // WRN_27: Bit-select ( data_in[4] ) is out-of-range
  assign out_bit_1 = data_in[5]; // WRN_27: Bit-select ( data_in[5] ) is out-of-range

endmodule
