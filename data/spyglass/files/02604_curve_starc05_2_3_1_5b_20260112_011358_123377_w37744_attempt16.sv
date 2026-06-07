`timescale 1ns/1ps

module curve_starc05_2_3_1_5b_20260112_011358_123377_w37744_attempt16 (
  input wire in_a,
  input wire in_b,
  input wire in_c,
  output wire out_1,
  output wire out_2,
  output wire out_3,
  output wire out_4,
  output wire out_5
);

  // STARC05-2.3.1.5b: Negative delay value '(-1)' used
  assign #(-1) out_1 = in_a;
  assign #(-1) out_2 = in_b;
  assign #(-1) out_3 = in_a & in_b;
  assign #(-1) out_4 = in_b | in_c;
  assign #(-1) out_5 = ~in_c;

endmodule
