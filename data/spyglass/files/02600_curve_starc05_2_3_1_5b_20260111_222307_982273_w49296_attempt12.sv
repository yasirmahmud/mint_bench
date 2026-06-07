`timescale 1ns / 1ps

module curve_starc05_2_3_1_5b_20260111_222307_982273_w49296_attempt12 (
  input wire in_a,
  input wire in_b,
  output wire out_p1,
  output wire out_p2,
  output wire out_p3,
  output wire out_p4,
  output wire out_p5
);

  // STARC05-2.3.1.5b: Negative delay value '(-1)' used
  assign #(-1) out_p1 = in_a;
  assign #(-1) out_p2 = in_b;
  assign #(-1) out_p3 = in_a ^ in_b;
  assign #(-1) out_p4 = in_a | in_b;
  assign #(-1) out_p5 = ~in_b;

endmodule
