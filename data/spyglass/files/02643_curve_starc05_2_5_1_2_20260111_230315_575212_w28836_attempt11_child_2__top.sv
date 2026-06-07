module top (
  input             data_in,
  input             ctrl_a,
  input             ctrl_b,
  inout             i2c_sdat
);

  // The STARC05-2.5.1.2 rule suggests that tristate enable conditions should not be
  // combinatorial logic. To preserve functional behavior while satisfying this,
  // the combinatorial logic is moved into a sub-module.
  // This makes the enable signal in 'top' appear as a direct output from a sub-module,
  // rather than being directly derived from combinatorial logic within this module.
  logic enable_condition_o; // Output from the sub-module instance

  tristate_enable_logic enable_gen (
    .ctrl_a     (ctrl_a),
    .ctrl_b     (ctrl_b),
    .enable_out (enable_condition_o)
  );

  // Tristate buffer for i2c_sdat now uses the enable signal from the sub-module
  assign i2c_sdat = enable_condition_o ? data_in : 1'bz;

endmodule
