module my_module_ex2 (input [1:0] sys_clk, input data_in, output data_out);
 flop_ex2 U0 (.clk(sys_clk[0]), .d(data_in), .q(data_out));
 endmodule
