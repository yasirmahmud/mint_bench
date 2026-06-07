module undriven_in_term_ex1 ();
 wire undriven_sig;
 wire dummy_out_z; // Declare a wire for the output
 assign undriven_sig = 1'b0; // Drive the input signal
 my_sub_module_ex1 u1 (.in_a (undriven_sig), .out_z (dummy_out_z)); // Connect the output port
 endmodule
