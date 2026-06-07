module curve_wrn_27_20260110_213804_attempt2 (
  input wire [3:0] data_in,
  output wire data_out_error1,
  output wire data_out_error2,
  output wire data_out_valid
);

  // Declare a 4-bit vector, with valid indices from 0 to 3
  wire [3:0] my_vec;

  // Assign data_in to my_vec. This ensures data_in and the valid range of my_vec (bits 0-3) are driven.
  assign my_vec = data_in;

  // This assignment uses all bits of my_vec within its valid range (0 to 3).
  // This ensures that my_vec[3:0] is read, preventing 'W528: Variable set but not read'
  // for the valid portion of the vector.
  assign data_out_valid = my_vec[0] ^ my_vec[1] ^ my_vec[2] ^ my_vec[3];

  // These lines trigger WRN_27 because they attempt to access bit indices 4 and 5
  // of 'my_vec', which is declared as [3:0] and therefore only has valid indices up to 3.
  // Each of these will generate one WRN_27 violation.
  assign data_out_error1 = my_vec[4]; // First WRN_27 occurrence (out-of-range bit-select)
  assign data_out_error2 = my_vec[5]; // Second WRN_27 occurrence (out-of-range bit-select)

endmodule
