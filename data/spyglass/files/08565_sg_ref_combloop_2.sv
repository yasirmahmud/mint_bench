module comb_loop_ex2 (input i_in, output o_out);
 wire s1, s2;
 assign s1 = ~s2;
 assign s2 = ~s1;
 assign o_out = s1 & i_in;
 endmodule
