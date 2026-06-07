module undriven_in_term_ex1 ();
 wire undriven_sig;
 assign undriven_sig = 1'b0;
 my_sub_module_ex1 u1 (.in_a (undriven_sig), .out_z ());
 endmodule
