`timescale 1ns/1ps

module curve_starc05_2_3_1_5b_20260111_183223_280126_w37940_attempt7 (
  input wire i_in1,
  input wire i_in2,
  output wire o_out1,
  output wire o_out2,
  output wire o_out3,
  output wire o_out4,
  output wire o_out5
);

  assign #(-1) o_out1 = i_in1;
  assign #(-1) o_out2 = i_in2;
  assign #(-1) o_out3 = i_in1 & i_in2;
  assign #(-1) o_out4 = i_in1 | i_in2;
  assign #(-1) o_out5 = ~i_in1;

endmodule
