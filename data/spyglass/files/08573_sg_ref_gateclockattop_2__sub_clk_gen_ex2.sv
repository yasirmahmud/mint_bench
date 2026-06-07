module sub_clk_gen_ex2(in_sig, out_clk);
 input in_sig;
 output out_clk;
 reg out_clk;
 always @(posedge in_sig) begin out_clk = ~out_clk;
 end endmodule
