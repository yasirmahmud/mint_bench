module curve_synth_5264_20260110_175813_attempt8 (
  // Parameters for fixed-point representation. Moved to the module header
  // to resolve "Identifier not declared" errors for port declarations.
  // TOTAL_WIDTH: The total number of bits for the fixed-point number (including sign bit).
  //              Defaulted to 32 bits, a common width for fixed-point arithmetic.
  parameter int TOTAL_WIDTH = 32,
  // FRAC_WIDTH: The number of fractional bits.
  //             Defaulted to 16 bits, providing a Q(TOTAL_WIDTH-FRAC_WIDTH-1).FRAC_WIDTH format.
  //             This choice assumes a balance between integer range and fractional precision.
  parameter int FRAC_WIDTH = 16,

  input signed [TOTAL_WIDTH-1:0] in_val,
  output signed [TOTAL_WIDTH-1:0] out_val
);

  // The original operation is 'out_val = in_val * 2.5'.
  // In fixed-point arithmetic, 2.5 can be exactly represented as 5/2.
  // Therefore, the operation can be performed as 'out_val = (in_val * 5) / 2'.

  // Intermediate wire to store the result of 'in_val * 5'.
  // When multiplying a 'TOTAL_WIDTH'-bit signed number by 5 (which is '101' in binary),
  // the product can potentially require up to 3 additional bits to prevent overflow
  // before the subsequent division. For example, a 32-bit input multiplied by 5
  // could require up to 35 bits.
  // 'TOTAL_WIDTH + 3' ensures sufficient width for the intermediate product.
  localparam int INTERMEDIATE_WIDTH = TOTAL_WIDTH + 3;
  // Fixed STX_VE_481: Changed 'signed logic' to 'wire signed' for broader Verilog tool compatibility.
  wire signed [INTERMEDIATE_WIDTH-1:0] product_by_five;

  // Step 1: Perform multiplication by 5.
  // The result 'product_by_five' conceptually maintains the same FRAC_WIDTH as 'in_val'.
  assign product_by_five = in_val * 5;

  // Step 2: Perform division by 2.
  // Division by 2 in fixed-point arithmetic is equivalent to an arithmetic right shift by 1.
  // An arithmetic right shift (`>>>`) is used to preserve the sign of the number,
  // which is crucial for signed fixed-point values.
  // The result of `product_by_five >>> 1` is implicitly truncated to the width of `out_val`
  // (which is TOTAL_WIDTH). This effectively aligns the fixed-point representation
  // to the desired output format, maintaining 'FRAC_WIDTH' fractional bits.
  assign out_val = product_by_five >>> 1;

endmodule
