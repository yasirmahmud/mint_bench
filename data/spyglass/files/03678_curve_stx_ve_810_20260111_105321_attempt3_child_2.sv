module curve_stx_ve_810_20260111_105321_attempt3(
  input [3:0] input_exponent, // A non-constant input for the exponent
  output wire out_data
);

  // To resolve SYNTH_5285 (System function '$rtoi' is not synthesizable)
  // and other synthesis issues related to floating-point arithmetic (like 2.0 ** input_exponent),
  // the calculation is converted to synthesizable fixed-point integer arithmetic.
  // We aim to calculate: floor(3.14159 * (2.0 ** input_exponent))

  // Fixed-point representation of 3.14159
  // We multiply 3.14159 by 2^FRACTION_BITS to convert it to an integer.
  // 3.14159 * (2^16) = 3.14159 * 65536 = 205887.89... -> rounded to 205888
  localparam [31:0] PI_FIXED_POINT = 205888;
  localparam integer FRACTION_BITS = 16;

  // This wire will hold 2 raised to the power of input_exponent.
  // input_exponent is [3:0], max value is 15. So 2^15 = 32768, which fits in 16 bits.
  wire [15:0] power_of_2_val;
  assign power_of_2_val = 1'b1 << input_exponent;

  // Intermediate product needs to be wide enough to prevent overflow.
  // Max value for PI_FIXED_POINT is 205888 (18 bits).
  // Max value for power_of_2_val is 32768 (16 bits).
  // Max product = 205888 * 32768 = 6747514880.
  // log2(6747514880) is approximately 32.65, so 33 bits ([32:0]) are needed for the product.
  wire [32:0] intermediate_product;
  assign intermediate_product = PI_FIXED_POINT * power_of_2_val;

  // Declare a wire to hold the final calculated integer value.
  // Max expected value: floor(3.14159 * 2^15) = floor(103028.93792) = 103028.
  // This value fits within 32 bits.
  // The right shift by FRACTION_BITS effectively divides by 2^FRACTION_BITS,
  // extracting the integer part from the fixed-point product.
  wire [31:0] scaled_calculated_value;
  assign scaled_calculated_value = intermediate_product >> FRACTION_BITS;

  // Use the calculated value, maintaining the original assignment logic.
  // out_data is assigned the LSB of the calculated integer.
  assign out_data = scaled_calculated_value[0];

endmodule
