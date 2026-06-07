`timescale 1ns/1ps
module curve_starc05_2_3_1_5b_20260111_183223_280126_w37940_attempt9 (
  input i_in,
  output o_out1,
  output o_out2,
  output o_out3,
  output o_out4,
  output o_out5
);

  assign #(-1) o_out1 = i_in;
  assign #(-1) o_out2 = ~i_in;
  assign #(-1) o_out3 = 1'b1;
  assign #(-1) o_out4 = 1'b0;
  assign #(-1) o_out5 = i_in;

endmodule
