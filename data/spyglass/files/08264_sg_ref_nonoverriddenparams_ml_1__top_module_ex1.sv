module top_module_ex1;
 wire clk_i;
 wire out_o;
 param_mod_ex1 u_inst (.clk(clk_i), .out(out_o));
 assign clk_i = 1'b0;
 endmodule
