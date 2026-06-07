module curve_stx_ve_418_20260110_164427_attempt7 (
  input  sys_clk_in,
  output sys_clk_buffered_out
);

  // Drive the output with a buffer (a gate primitive).
  // This ensures 'sys_clk_buffered_out' is driven by a gate output.
  buf (sys_clk_buffered_out, sys_clk_in);

  // STX_VE_418 violation:
  // The path's source ('sys_clk_in') is an input port.
  // Input ports are not considered "driven by a gate output" within the module,
  // thus triggering STX_VE_418.
  specify
    (sys_clk_in => sys_clk_buffered_out) = 1;
  endspecify

endmodule
