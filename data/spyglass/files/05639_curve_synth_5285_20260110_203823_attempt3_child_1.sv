module curve_synth_5285_20260110_203823_attempt3 (
  input        [1:0] in_vec,
  input              single_bit,
  output reg         out_hot_status,
  output reg         out_hot0_status
);

  // First occurrence of SYNTH_5285 (using $onehot)
  // $onehot(in_vec) is true if exactly one bit of in_vec is high.
  // For a 2-bit vector, this is equivalent to checking if the bits are different.
  always @* begin
    out_hot_status = in_vec[0] ^ in_vec[1];
  end

  // Second occurrence of SYNTH_5285 (using $onehot0)
  // $onehot0(single_bit) is true if at most one bit of single_bit is high.
  // For a single bit, this condition is always true (0 or 1 bit is high).
  always @* begin
    out_hot0_status = 1'b1;
  end

endmodule
