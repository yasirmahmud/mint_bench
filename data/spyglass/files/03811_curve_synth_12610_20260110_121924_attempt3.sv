module curve_synth_12610_20260110_121924_attempt3 (
  input wire clk,
  input wire reset_n,
  input wire start_condition,
  output wire dummy_output
);

  // This SystemVerilog 'sequence' block is intentionally included in a Verilog-2001 module
  // to demonstrate how linting tools like SpyGlass detect and flag unsynthesizable
  // SystemVerilog constructs when the target synthesis environment does not support them.
  // The large delay range (e.g., ##[0:1200]) specifically triggers SYNTH_12610 as
  // it indicates the sequence will be ignored for synthesis.
  sequence s_flexible_delay;
    @(posedge clk) start_condition ##[0:1200] (reset_n == 0);
  endsequence

  // Drive 'dummy_output' with a simple expression involving all inputs to avoid
  // any 'unused input' warnings, as the unsynthesizable sequence itself might not
  // be considered a "use" for all linting tools.
  assign dummy_output = start_condition & reset_n & clk;

endmodule
