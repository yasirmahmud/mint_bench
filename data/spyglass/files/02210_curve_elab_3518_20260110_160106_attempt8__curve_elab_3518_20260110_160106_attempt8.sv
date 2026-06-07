module curve_elab_3518_20260110_160106_attempt8 (
  input wire system_clk,
  output wire system_out
);

  // Instantiate processing_block and override its DELAY_TIME parameter with a double literal
  processing_block #(.DELAY_TIME(2.7)) processing_block_inst (
    .data_in  (system_clk),
    .data_out (system_out)
  );

endmodule
