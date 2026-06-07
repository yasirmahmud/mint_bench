module curve_wrn_27_20260110_213804_attempt1 (
  input wire [7:0] data_in,
  output wire data_out
);

  // Declare an 8-bit vector, with valid indices from 0 to 7
  wire [7:0] internal_vec;

  // Assign data_in to internal_vec to avoid unused signal warnings for data_in
  assign internal_vec = data_in;

  // This line triggers WRN_27 because it attempts to access bit index 8
  // of 'internal_vec', which is declared as [7:0] and therefore only
  // has valid indices up to 7.
  assign data_out = internal_vec[8];

endmodule
