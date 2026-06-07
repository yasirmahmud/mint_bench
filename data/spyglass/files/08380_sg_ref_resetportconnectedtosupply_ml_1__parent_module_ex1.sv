module parent_module_ex1 (input clk_in, input d_in, output q_out);
 child_module_ex1 u_child (.clk(clk_in), .rst_n(1'b0), .d(d_in), .q(q_out));
 endmodule
