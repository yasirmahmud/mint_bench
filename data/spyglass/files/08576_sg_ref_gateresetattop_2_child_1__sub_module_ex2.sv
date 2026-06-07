module sub_module_ex2 (clk, in, reset_out);
 input clk, in;
 output reset_out;
 reg reset_out;
 always @ (posedge clk) reset_out = ~in;
 endmodule
