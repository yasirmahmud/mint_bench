module mod1_ex2 (input clk, output out_q);
 wire internal_q;
 mod2_ex2 u_mod2_ex2 (.clk(clk), .rst_n(1'b0), .q(internal_q));
 assign out_q = internal_q;
 endmodule
