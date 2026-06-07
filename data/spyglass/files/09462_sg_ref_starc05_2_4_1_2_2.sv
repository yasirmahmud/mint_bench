module latch_other_ex2 (i_data, i_en, o_latch, o_comb);
 input i_data, i_en;
 output o_latch, o_comb;
 reg o_latch;
 assign o_comb = i_data & i_en;
 always @(i_en) if (i_en) o_latch = i_data;
 endmodule
