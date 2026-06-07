module top (
  input wire data_in,
  input wire control_a,
  input wire control_b,
  output wire i2c_sdat
);

  // Intermediate signal to hold the logic for the tristate enable
  // Changed from 'reg' to 'wire' and driven by an 'assign' statement
  // as it is purely combinational logic feeding an explicit gate primitive.
  wire enable_condition;

  // The enable condition is derived from combinatorial logic (OR operation)
  // This logic is now encapsulated in an assign statement for the 'wire'.
  assign enable_condition = control_a || control_b;

  // Tristate buffer where the enable condition 'enable_condition'
  // is now driven by a wire from an assign statement, and the tristate
  // functionality is implemented using an explicit bufif1 gate primitive.
  // This commonly resolves STARC05-2.5.1.2 by making the tristate logic explicit
  // rather than inferred from a conditional assignment, and providing a direct
  // enable signal to the primitive.
  bufif1 u_i2c_sdat_tristate (i2c_sdat, data_in, enable_condition);

endmodule
