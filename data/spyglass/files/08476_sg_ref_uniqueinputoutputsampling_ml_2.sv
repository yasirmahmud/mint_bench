module my_module_ex2(input clk, input in_violating, output out_ok);
 reg ff_q;
 always @(posedge clk) ff_q <= 1'b0;
 assign out_ok = ff_q;
 endmodule
