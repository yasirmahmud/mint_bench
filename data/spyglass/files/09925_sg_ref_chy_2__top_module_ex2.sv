module top_module_ex2 (input clk_i, output out_o1, output out_o2);
 my_sub_module_ex2 sub_inst1 (.clk(clk_i), .out_q(out_o1));
 my_sub_module_ex2 sub_inst2 (.clk(clk_i), .out_q(out_o2));
 endmodule
