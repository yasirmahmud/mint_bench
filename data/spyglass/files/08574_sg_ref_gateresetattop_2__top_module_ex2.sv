module top_module_ex2 (clk, in, out);
 input clk, in;
 output out;
 wire reset_sig;
 sub_module_ex2 inst_sub (clk, in, reset_sig);
 always @ (posedge clk or posedge reset_sig) if (reset_sig) out = 1'b0;
 else out = in;
 endmodule
