module curve_synth_5290_20260111_024903_attempt13 (
  input wire [7:0] in_data,
  output wire [7:0] out_data
);

  // The original 'real' parameter SCALE_FACTOR causes SYNTH_5290 violation.
  // To preserve functional behavior while being synthesizable, we convert
  // the real factor (1.5) into a fixed-point integer representation.
  // 1.5 can be represented as 3 with 1 fractional bit (3 / 2^1 = 1.5).
  parameter integer PARAM_SCALE_FACTOR_INT = 3;
  parameter integer NUM_FRACTIONAL_BITS = 1;

  // Calculate the minimum required width for the intermediate product.
  // Max value of in_data (8 bits) is 255.
  // Max intermediate product = 255 * PARAM_SCALE_FACTOR_INT = 255 * 3 = 765.
  // $clog2(765+1) = 10 bits are required to hold 765.
  localparam integer PRODUCT_WIDTH = $clog2((2**8-1) * PARAM_SCALE_FACTOR_INT + 1);

  // Declare a wire to hold the intermediate product after scaling up.
  wire [PRODUCT_WIDTH-1 : 0] product_scaled_up;

  // Perform the fixed-point multiplication: in_data * (1.5 * 2^NUM_FRACTIONAL_BITS).
  assign product_scaled_up = in_data * PARAM_SCALE_FACTOR_INT;

  // Divide by 2^NUM_FRACTIONAL_BITS (right shift) to get the final scaled integer value.
  // When assigned to 'out_data' (8 bits), the result is implicitly truncated
  // to the lower 8 bits. This preserves the wraparound behavior that would occur
  // from assigning a real number (e.g., 382.5 for in_data=255) to an 8-bit wire
  // (e.g., 382 becomes 382 % 256 = 126).
  // To resolve W486, we explicitly slice the shifted result to 8 bits,
  // matching the width of 'out_data' and preserving the intended truncation/wraparound.
  assign out_data = (product_scaled_up >> NUM_FRACTIONAL_BITS)[7:0];

endmodule
