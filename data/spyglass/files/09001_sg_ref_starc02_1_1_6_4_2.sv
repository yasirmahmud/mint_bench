module my_module_ex2 (input clk, output reg out_q);
 initial out_q = 1'b0;
 always @(posedge clk) out_q <= ~out_q;
 endmodule
