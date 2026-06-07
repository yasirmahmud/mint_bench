module my_module_ex2(input clk, output my_signal);
 wire dummy_clk_read = clk;
 parameter MY_CONSTANT = 8;
 assign my_signal = 1'b0;
 endmodule
