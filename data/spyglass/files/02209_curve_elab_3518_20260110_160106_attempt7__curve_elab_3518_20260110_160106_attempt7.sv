module curve_elab_3518_20260110_160106_attempt7 (
  input wire clk,
  output wire out
);

  my_block #(.DIV_FACTOR(3.5)) my_block_inst (
    .clk_in  (clk),
    .clk_out (out)
  );

endmodule
