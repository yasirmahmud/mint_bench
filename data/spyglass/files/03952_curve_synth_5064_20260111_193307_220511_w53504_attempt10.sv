module curve_synth_5064_20260111_193307_220511_w53504_attempt10 (
  input wire clk,
  input wire enable
);

  // This cover property statement is a SystemVerilog construct
  // and is explicitly identified as non-synthesizable by SYNTH_5064.
  cover property (@(posedge clk) (enable));

endmodule
