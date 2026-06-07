module top_module_ex2 (input top_in, output top_out);
 wire unused_out_c;
 child_module_ex2 u_child (.in_a(top_in), .out_b(top_out), .out_c(unused_out_c));
 endmodule
