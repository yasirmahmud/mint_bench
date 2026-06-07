module curve_stx_ve_418_20260110_113444_attempt5 (
  input external_clk
);

  // STX_VE_418: Path ( external_clk ) is not valid, because it is not driven by a gate output
  // 'external_clk' is an input port. While it serves as a source for timing paths, it is not
  // internally driven by a 'gate output' within this module, thus triggering STX_VE_418.
  // Using an input port for the path source (as seen in context example 2 for `p_in`)
  // is expected to avoid the STX_VE_416 violation (which flags invalid input-paths),
  // as an input port is a valid path origin from the module's perspective.
  // A SYNTH_92 warning may still occur due to the use of a specify block, as seen in provided
  // context examples. The primary goal is to achieve exactly one FATAL STX_VE_418 violation.
  specify
    (external_clk => external_clk) = 1;
  endspecify

endmodule
