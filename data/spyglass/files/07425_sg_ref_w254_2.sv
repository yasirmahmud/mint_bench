module W254_ex2(input clk, input data);
 wire ref_sig;
 assign ref_sig = clk;
 $setup(data, ref_sig, 10);
 endmodule
