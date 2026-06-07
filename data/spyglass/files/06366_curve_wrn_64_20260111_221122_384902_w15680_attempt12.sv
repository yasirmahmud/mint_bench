// Verilog-2001
module curve_wrn_64_attempt12_dut (
  input [7:0] data_in,
  output [7:0] out_high_oob,
  output [7:0] out_low_oob
);

  // Parameters for out-of-range part-select indices
  // Base vector: data_in[7:0]
  parameter OOB_HIGH_MSB = 8;  // Greater than data_in's MSB (7)
  parameter OOB_HIGH_LSB = 1;  // Within data_in's range [0:7]

  parameter OOB_LOW_MSB = 6;   // Within data_in's range [0:7]
  parameter OOB_LOW_LSB = -1;  // Less than data_in's LSB (0)

  // WRN_64 occurrence 1:
  // Part-select [OOB_HIGH_MSB:OOB_HIGH_LSB] i.e., [8:1]
  // The MSB index '8' is out-of-range (greater than 7).
  assign out_high_oob = data_in[OOB_HIGH_MSB:OOB_HIGH_LSB];

  // WRN_64 occurrence 2:
  // Part-select [OOB_LOW_MSB:OOB_LOW_LSB] i.e., [6:-1]
  // The LSB index '-1' is out-of-range (less than 0).
  assign out_low_oob = data_in[OOB_LOW_MSB:OOB_LOW_LSB];

endmodule
