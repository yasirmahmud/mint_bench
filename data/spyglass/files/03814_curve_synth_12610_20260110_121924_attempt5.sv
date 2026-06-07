module curve_synth_12610_20260110_121924_attempt5 (
  input wire clk,
  input wire trigger_start,
  input wire trigger_end,
  output wire dummy_out
);

  // This SystemVerilog 'sequence' construct will be ignored by Verilog-2001 synthesis tools.
  // The rule SYNTH_12610 specifically flags such blocks, indicating they are not synthesized.
  // The large delay range ##[10:100] is characteristic, but the mere presence of 'sequence'
  // in a Verilog-2001 context is enough to trigger the warning.
  sequence another_seq_for_synth_ignore;
    trigger_start ##[10:100] trigger_end;
  endsequence

  // Simple logic to use all inputs and avoid unused signal warnings.
  assign dummy_out = clk ^ trigger_start | trigger_end;

endmodule
