module top (
  input             data_in,
  input             ctrl_a,
  input             ctrl_b,
  inout             i2c_sdat
);

  wire              enable_condition;

  // The enable condition for the tristate buffer contains logic (ctrl_a AND ctrl_b).
  // This triggers STARC05-2.5.1.2.
  assign enable_condition = ctrl_a && ctrl_b;

  // Tristate buffer for i2c_sdat with derived enable logic
  assign i2c_sdat = enable_condition ? data_in : 1'bz;

endmodule
