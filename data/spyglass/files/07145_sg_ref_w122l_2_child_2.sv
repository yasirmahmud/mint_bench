module latch_w122l_ex2 (input en, input d, output q_out);
 reg q_reg;
 // sg_waive_line InferLatch "Latch is intentional as per design specification for level-sensitive behavior. This is not a functional bug."
 always @* begin // Fixed W122: 'd' added to sensitivity list for proper latch behavior
   if (en) q_reg <= d;
   // Latch inferred for 'q_reg' is expected as per design intent (level-sensitive behavior).
   // The 'InferLatch' violation is an observation, not a functional bug to be removed.
 end
 assign q_out = q_reg;
 endmodule
