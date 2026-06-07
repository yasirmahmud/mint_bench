module undriven_in_term_ex1 ();
 wire undriven_sig;
 my_sub_module_ex1 u1 (.in_a (undriven_sig), .out_z ());
 endmodule
