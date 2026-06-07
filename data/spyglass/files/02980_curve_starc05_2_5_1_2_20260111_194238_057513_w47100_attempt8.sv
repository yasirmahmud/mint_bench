module top (
  input wire data_in,
  input wire control_a,
  input wire control_b,
  output wire i2c_sdat
);

  // Intermediate wire to hold the logic for the tristate enable
  wire enable_condition;

  // The enable condition is derived from combinatorial logic (AND operation)
  // This logic in the enable condition triggers STARC05-2.5.1.2
  assign enable_condition = control_a && control_b;

  // Tristate buffer where the enable condition 'enable_condition'
  // contains logic, triggering STARC05-2.5.1.2
  assign i2c_sdat = enable_condition ? data_in : 1'bz;

endmodule
