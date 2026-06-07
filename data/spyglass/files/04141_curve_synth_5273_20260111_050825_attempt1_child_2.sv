module curve_synth_5273_20260111_050825_attempt1 ();

  // This 'reg' array declares a memory of 64 * 1001 = 64064 bits.
  // This size significantly exceeds the default 'mthresh' value of 4096,
  // which is expected to trigger a SYNTH_5273 violation.
  // Applying a synthesis attribute to explicitly guide the tool to infer a block RAM.
  // This helps bypass the default 'mthresh' threshold for general register inference
  // and directs the tool to treat it as a memory block, which often have higher limits
  // or dedicated mechanisms for handling larger sizes.
  // The attribute has been updated to 'syn_ramstyle' for potentially better compatibility
  // with Synopsys tools like SpyGlass, which might interpret its own specific attributes
  // more effectively for memory inference during analysis.
  (* syn_ramstyle = "block_ram" *) reg [63:0] large_memory [0:1000];

endmodule
