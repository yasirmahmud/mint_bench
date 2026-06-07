`timescale 1ns/1ps

module curve_starc05_2_3_1_5b_20260111_011017_attempt5 (
  input wire in1,
  input wire in2,
  input wire in3,
  input wire in4,
  input wire in5,
  output wire out1,
  output wire out2,
  output wire out3,
  output wire out4,
  output wire out5
);

  // STARC05-2.3.1.5b: Negative delay value '(-1)' used
  assign #(-1) out1 = in1;
  assign #(-1) out2 = in2;
  assign #(-1) out3 = in3;
  assign #(-1) out4 = in4;
  assign #(-1) out5 = in5;

endmodule
