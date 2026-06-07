module top_module_ex2(top_in, top_out);
 input top_in;
 output top_out;
 reg top_out;
 wire internal_clk;
 sub_clk_gen_ex2 u_clk_gen (top_in, internal_clk);
 always @(posedge internal_clk) begin top_out = ~top_out;
 end endmodule
