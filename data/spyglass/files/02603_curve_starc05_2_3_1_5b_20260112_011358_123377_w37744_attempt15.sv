`timescale 1ns/1ps
module curve_starc05_2_3_1_5b_20260112_011358_123377_w37744_attempt15 (
  input wire signal_in,
  output wire output_reg1,
  output wire output_reg2,
  output wire output_reg3,
  output wire output_reg4,
  output wire output_reg5
);

  // STARC05-2.3.1.5b: Negative delay value '(-1)' used
  assign #(-1) output_reg1 = signal_in;
  assign #(-1) output_reg2 = ~signal_in;
  assign #(-1) output_reg3 = 1'b1;
  assign #(-1) output_reg4 = 1'b0;
  assign #(-1) output_reg5 = signal_in;

endmodule
