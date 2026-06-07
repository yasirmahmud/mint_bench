module my_module_ex2 (clk, in_data, out_q);
 input clk, in_data;
 output out_q;
 reg out_q;
 reg internal_reset;
 always @(posedge clk) internal_reset = in_data;
 always @(posedge clk or posedge internal_reset) if (internal_reset) out_q <= 1'b0;
 else out_q <= in_data;
 endmodule
