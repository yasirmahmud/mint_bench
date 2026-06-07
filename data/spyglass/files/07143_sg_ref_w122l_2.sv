module latch_w122l_ex2 (input en, input d, output q_out);
 reg q_reg;
 always @(en) if (en) q_reg <= d;
 assign q_out = q_reg;
 endmodule
