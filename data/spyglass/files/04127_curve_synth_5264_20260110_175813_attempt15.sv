module curve_synth_5264_20260110_175813_attempt15 (
  inout real bidirectional_real_port
);
  // The 'real' net type for a port is not supported in RTL synthesis,
  // triggering SYNTH_5264. The 'inout' type makes this example distinct.
  // Assigning a constant ensures the port is 'used' to avoid unused signal warnings.
  assign bidirectional_real_port = 3.14159;
endmodule
