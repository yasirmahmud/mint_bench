module curve_wrn_27_20260110_213804_attempt4 (
  input wire [3:0] data_in,
  output wire data_out_0,
  output wire data_out_1
);

  // Declare a wire of a specific width, e.g., 4 bits
  wire [3:0] my_vector;

  // Assign data_in to my_vector to prevent 'unused input' and 'undriven wire' warnings.
  assign my_vector = data_in;

  // Trigger WRN_27 rule twice with direct out-of-range bit-selects.
  // Access my_vector at index 4, which is out of range for a [3:0] vector.
  assign data_out_0 = my_vector[4]; // WRN_27: Bit-select out-of-range

  // Access my_vector at index 5, which is also out of range for a [3:0] vector.
  assign data_out_1 = my_vector[5]; // WRN_27: Bit-select out-of-range

endmodule
