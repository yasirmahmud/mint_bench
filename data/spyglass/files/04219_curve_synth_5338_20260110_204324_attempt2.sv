module curve_synth_5338_20260110_204324_attempt2 (
    input [1:0] base_in_1, // Max value 3
    input [2:0] base_in_2, // Max value 7
    output reg [4:0] result_1, // Max result for base_in_1 is 3**3 = 27 (needs 5 bits)
    output reg [8:0] result_2  // Max result for base_in_2 is 7**3 = 343 (needs 9 bits)
);

  // First instance of SYNTH_5338 violation:
  // base_in_1 is not guaranteed to be a power of 2 (e.g., if 3).
  // The exponent '3' is not 0, 1, or 2.
  always @(*) begin
    result_1 = base_in_1 ** 3;
  end

  // Second instance of SYNTH_5338 violation:
  // base_in_2 is not guaranteed to be a power of 2 (e.g., if 3, 5, 6, 7).
  // The exponent '3' is not 0, 1, or 2.
  always @(*) begin
    result_2 = base_in_2 ** 3;
  end

endmodule
