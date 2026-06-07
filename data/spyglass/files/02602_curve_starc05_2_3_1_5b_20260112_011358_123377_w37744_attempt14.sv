`timescale 1ns/1ps
module curve_starc05_2_3_1_5b_20260112_011358_123377_w37744_attempt14 (
  input wire i_data,
  input wire i_enable,
  output wire o_val1,
  output wire o_val2,
  output wire o_val3,
  output wire o_val4,
  output wire o_val5
);

  // STARC05-2.3.1.5b: Negative delay value '(-1)' used
  assign #(-1) o_val1 = i_data;
  assign #(-1) o_val2 = i_enable;
  assign #(-1) o_val3 = i_data & i_enable;
  assign #(-1) o_val4 = i_data | i_enable;
  assign #(-1) o_val5 = ~i_data;

endmodule
