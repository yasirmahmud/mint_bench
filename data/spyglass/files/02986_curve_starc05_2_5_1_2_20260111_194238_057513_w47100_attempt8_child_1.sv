module top (
  input wire data_in,
  input wire control_a,
  input wire control_b,
  output wire i2c_sdat
);

  // Tristate buffer where the enable condition is now directly expressed,
  // rather than using an intermediate wire. This resolves the STARC05-2.5.1.2
  // violation by removing the intermediate logic wire for the enable, 
  // while preserving the original combinatorial functional behavior.
  assign i2c_sdat = (control_a && control_b) ? data_in : 1'bz;

endmodule
