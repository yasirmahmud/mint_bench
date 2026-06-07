module my_module (
  input clk
);
  // Removed 'my_rand_signal' and its assignment as it was set but not read,
  // resolving SpyGlass W528 violation without changing functional behavior.
endmodule
