module UnusedRegisterExample2 (
  input clk,
  input rst_n,
  input in_a,
  input in_b
);

  // The unused registers 'unused_reg_a' and 'unused_reg_b' and their assignments
  // have been removed as they were set but never read, causing W528 violations.
  // This change preserves the functional behavior as they did not impact any
  // observable output or internal logic.

endmodule
