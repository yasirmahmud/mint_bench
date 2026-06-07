module curve_synth_5273_20260111_050825_attempt1 ();

  // This 'reg' array declares a memory of 64 * 1001 = 64064 bits.
  // This size significantly exceeds the default 'mthresh' value of 4096,
  // which is expected to trigger a SYNTH_5273 violation.
  reg [63:0] large_memory [0:1000];

endmodule
