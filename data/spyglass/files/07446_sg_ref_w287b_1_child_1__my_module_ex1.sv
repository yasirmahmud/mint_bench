module my_module_ex1 (input clk);
 wire unused_out_b;
 inner_mod i_inner (.in_a(clk), .out_b(unused_out_b));
 endmodule
