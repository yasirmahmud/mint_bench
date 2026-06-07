// Main module: Triggers W415 by having a wire driven by both an instantiated module
// and a continuous assignment.
module curve_w415_20260111_195512_878064_w47100_attempt8 (
  input wire data_in_a,
  input wire data_in_b,
  input wire carry_in_fa,
  output wire result_sum,
  output wire result_carry_out
);

  // This wire will have multiple simultaneous drivers
  wire intermediate_carry;

  // First driver: Instance of the full_adder module
  full_adder fa_inst (
    .a    (data_in_a),
    .b    (data_in_b),
    .cin  (carry_in_fa),
    .sum  (result_sum),
    .carry(intermediate_carry) // Drives intermediate_carry
  );

  // Second driver: Continuous assignment to the same wire
  // This is the source of the W415 violation.
  assign intermediate_carry = data_in_a | data_in_b; // Any simple expression will do

  // Ensure all module inputs are used and outputs are driven to avoid other linting warnings.
  assign result_carry_out = intermediate_carry; // Use intermediate_carry to prevent it from being unused.

endmodule
