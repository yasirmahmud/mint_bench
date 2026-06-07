module STARC05_2_4_1_4_ex1 (input wire en, output reg q_out);
 wire d_latch_in;
 wire loop_feedback;
 always @(*) begin if (en) begin q_out = d_latch_in;
 end end assign loop_feedback = ~q_out;
 assign d_latch_in = loop_feedback;
 endmodule
