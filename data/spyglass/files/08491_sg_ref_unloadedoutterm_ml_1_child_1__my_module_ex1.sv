module my_module_ex1 ();
 wire input_to_sub;
 assign input_to_sub = 1'b0;
 sub_mod inst_sub (.in_a(input_to_sub), .out_b());
 endmodule
