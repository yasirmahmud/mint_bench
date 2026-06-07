module curve_starc05_2_3_1_5b_20260112_011358_123377_w37744_attempt13 (
  input wire in_val_0,
  input wire in_val_1,
  input wire in_val_2,
  output wire out_delay_0,
  output wire out_delay_1,
  output wire out_delay_2,
  output wire out_delay_3,
  output wire out_delay_4
);

  // STARC05-2.3.1.5b: Negative delay value '(-1)' used
  assign #(-1) out_delay_0 = in_val_0;
  assign #(-1) out_delay_1 = ~in_val_1;
  assign #(-1) out_delay_2 = in_val_0 & in_val_2;
  assign #(-1) out_delay_3 = 1'b0;
  assign #(-1) out_delay_4 = in_val_1 | in_val_2;

endmodule
