module latch_w442aL_ex1 (input d_in, en_in, output reg comb_out, latch_out);
 always @(d_in or en_in) begin comb_out = d_in;
 if (en_in) latch_out = d_in;
 end endmodule
