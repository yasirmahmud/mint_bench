module top (
  input wire data_in,
  input wire control_a,
  input wire control_b,
  output wire i2c_sdat
);

  // Intermediate wire for the tristate enable condition.
  // This resolves the STARC05-2.5.1.2 violation by separating the enable logic
  // into a dedicated wire, ensuring the tristate buffer's enable input is a direct signal,
  // while preserving the original combinatorial functional behavior.
  wire enable_i2c_sdat;
  assign enable_i2c_sdat = control_a && control_b;

  assign i2c_sdat = enable_i2c_sdat ? data_in : 1'bz;

endmodule
