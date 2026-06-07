module cascaded_latches_ex2 (input clk_en, input d_in, output q_out);
 reg l1_q, l2_q;
 always @* if (clk_en) l1_q = d_in;
 always @* if (clk_en) l2_q = l1_q;
 assign q_out = l2_q;
 endmodule
