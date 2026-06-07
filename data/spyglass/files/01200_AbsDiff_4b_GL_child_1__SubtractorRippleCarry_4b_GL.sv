module SubtractorRippleCarry_4b_GL
(
  input  wire [3:0] in0,
  input  wire [3:0] in1,
  input  wire       bin,
  output wire       bout,
  output wire [3:0] diff
);
  // Perform 4-bit subtraction with borrow-in and generate borrow-out
  // Using a 5-bit intermediate wire to capture the borrow-out (MSB)
  wire [4:0] temp_diff = {1'b0, in0} - {1'b0, in1} - bin;
  assign diff = temp_diff[3:0];
  assign bout = temp_diff[4]; // bout is 1 if a borrow occurred
endmodule
