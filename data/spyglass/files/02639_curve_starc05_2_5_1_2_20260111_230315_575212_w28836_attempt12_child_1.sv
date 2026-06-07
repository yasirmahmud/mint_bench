module top (
  input             data_in,
  input             enable_cond_a,
  input             enable_cond_b,
  inout             i2c_sdat
);

  // To resolve STARC05-2.5.1.2, move the logic from the tristate enable condition
  // into a separate wire assignment.
  wire tristate_enable_i2c_sdat;
  assign tristate_enable_i2c_sdat = enable_cond_a || enable_cond_b;

  assign i2c_sdat = tristate_enable_i2c_sdat ? data_in : 1'bz;

endmodule
