module curve_synth_12610_20260110_121924_attempt4 (
  input wire clk,
  input wire start_signal,
  input wire finish_condition_monitor,
  output wire dummy_out
);

  // This SystemVerilog 'sequence' block is intentionally included in a Verilog-2001 module.
  // Synthesis tools configured for Verilog-2001 will ignore this construct.
  // The presence of a 'sequence' construct, especially with a large delay range like ##[1:1100],
  // triggers SYNTH_12610, indicating it will be ignored for synthesis.
  sequence s_long_wait_sequence;
    @(posedge clk) start_signal ##[1:1100] finish_condition_monitor;
  endsequence

  // Drive 'dummy_out' with a simple expression involving all inputs to avoid
  // any 'unused input' warnings, as the unsynthesizable sequence itself might not
  // be considered a "use" for all linting tools.
  assign dummy_out = clk & start_signal | finish_condition_monitor;

endmodule
