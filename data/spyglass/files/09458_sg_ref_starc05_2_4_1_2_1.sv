module latch_mixed_ex1 (IN1, SET, IN2, OUT_LATCH, OUT_COMB);
 input IN1, SET, IN2;
 output OUT_LATCH, OUT_COMB;
 reg OUT_LATCH;
 wire net1;
 assign net1 = IN2;
 assign OUT_COMB = IN1 & net1;
 always @(SET) begin if (SET) begin OUT_LATCH = IN1;
 end end endmodule
