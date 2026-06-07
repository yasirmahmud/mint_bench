module top (
  input             data_in,
  input             enable_cond_a,
  input             enable_cond_b,
  inout             i2c_sdat
);

  // The tristate buffer's enable condition directly contains logic
  // (enable_cond_a || enable_cond_b), which triggers STARC05-2.5.1.2.
  assign i2c_sdat = (enable_cond_a || enable_cond_b) ? data_in : 1'bz;

endmodule
