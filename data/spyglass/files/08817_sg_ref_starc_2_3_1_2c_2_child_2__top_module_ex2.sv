module top_module_ex2;
 reg d_in, clk_in;
 wire q_out;
 unsynth_ff_ex2 u_ff (.q(q_out), .d(d_in), .clk(clk_in));
 endmodule
