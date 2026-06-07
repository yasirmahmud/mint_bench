module latch_w442aL_ex2 (enable, data, q_latch, q_comb);
 input enable, data;
 output q_latch, q_comb;
 reg q_latch;
 reg q_comb;
 always @(enable or data) begin q_comb = data;
 if (enable) q_latch <= data;
 end endmodule
