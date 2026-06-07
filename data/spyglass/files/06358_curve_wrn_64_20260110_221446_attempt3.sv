module curve_wrn_64_20260110_221446_attempt3 #(
  parameter INPUT_WIDTH = 8
) (
  input wire [INPUT_WIDTH - 1 : 0] data_in,
  output wire [INPUT_WIDTH - 1 : 0] out_high_oob,
  output wire [INPUT_WIDTH - 1 : 0] out_low_oob
);

  // WRN_64 violation 1: Part-select high index is out-of-range.
  // With default INPUT_WIDTH=8, data_in is [7:0].
  // The part-select data_in[INPUT_WIDTH:1] becomes data_in[8:1].
  // Index 8 is out of range for a [7:0] vector.
  // The width of the part-select (8 bits) matches the output width.
  assign out_high_oob = data_in[INPUT_WIDTH:1];

  // WRN_64 violation 2: Part-select low index is out-of-range.
  // With default INPUT_WIDTH=8, data_in is [7:0].
  // The part-select data_in[(INPUT_WIDTH - 2):-1] becomes data_in[6:-1].
  // Index -1 is out of range for a [7:0] vector.
  // The width of the part-select (8 bits) matches the output width.
  assign out_low_oob = data_in[INPUT_WIDTH - 2:-1];

endmodule
