module combinational_loop_latch_ex2 (input en, output reg q_out);
 assign q_out = (en) ? ~q_out : q_out;
 endmodule
