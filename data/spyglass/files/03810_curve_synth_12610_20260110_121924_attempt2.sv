module curve_synth_12610_20260110_121924_attempt2 (
  input wire clk,
  input wire start_signal,
  input wire end_signal,
  output wire dummy_out
);

  // This sequence block is specifically crafted to trigger SYNTH_12610.
  // The rule 'large_delay_range_seq' targets SystemVerilog 'sequence' blocks
  // with significant cycle delay ranges (e.g., ##[1:1000]), indicating they will
  // be ignored for synthesis. While the module targets Verilog-2001, linting
  // tools like SpyGlass will parse SystemVerilog constructs and flag them if
  // they are unsynthesizable in the target context.
  sequence s_delay_check;
    start_signal ##[1:1000] end_signal; // This line is the target of the SYNTH_12610 violation
  endsequence

  // Drive 'dummy_out' with a simple expression involving all inputs to avoid
  // unused input warnings for clk, start_signal, and end_signal, as the sequence
  // itself might not be considered a "use" for all linters without a property/assert.
  assign dummy_out = start_signal & end_signal & clk;

endmodule
