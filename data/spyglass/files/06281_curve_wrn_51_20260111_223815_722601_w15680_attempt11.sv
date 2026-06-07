module curve_wrn_51_20260111_223815_722601_w15680_attempt11 (
  input [3:0] in_a,
  input [3:0] in_b,
  output reg [39:0] out_concatenated
);

  // WRN_51: The unsized number '7' in the concatenation triggers the violation.
  // 'in_a' (4 bits) + '7' (32 bits default) + 'in_b' (4 bits) = 40 bits.
  // 'out_concatenated' is explicitly sized to 40 bits to prevent width mismatch warnings.
  always @(*) begin
    out_concatenated = {in_a, 7, in_b};
  end

endmodule
