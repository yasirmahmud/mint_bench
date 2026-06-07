module top (
  input wire data_in,
  input wire control_a,
  input wire control_b,
  output wire i2c_sdat
);

  // Intermediate wire to hold the logic for the tristate enable
  wire enable_signal_logic;

  // The enable condition is derived from combinatorial logic
  assign enable_signal_logic = control_a && control_b;

  // Tristate buffer where the enable condition 'enable_signal_logic'
  // contains logic, triggering STARC05-2.5.1.2
  assign i2c_sdat = enable_signal_logic ? data_in : 1'bz;

endmodule
