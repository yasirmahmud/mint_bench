module curve_w415_20260111_195512_878064_w47100_attempt9 (
  input wire a_in,
  input wire b_in,
  input wire c_in,
  output wire result_out
);

  // This wire will have multiple simultaneous drivers, causing W415
  wire conflict_wire;

  // First continuous assignment to conflict_wire
  assign conflict_wire = a_in & b_in;

  // Second continuous assignment to the same conflict_wire
  // This directly triggers the W415 violation.
  assign conflict_wire = a_in | c_in;

  // Use all inputs and the conflict_wire to prevent other linting warnings
  assign result_out = conflict_wire ^ b_in;

endmodule
