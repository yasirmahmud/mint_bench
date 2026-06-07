module top_module_ex1 ();
 // The 'my_signal' wire was previously set but not read, causing a W528 violation.
 // To resolve this without changing the functional behavior of top_module_ex1
 // (which did not use 'my_signal'), the 'out_z' port of u_sub_ex1 is now
 // explicitly left unconnected. This effectively removes the unused signal.
 sub_module_ex1 u_sub_ex1 (.in_a (1'b1), .out_z ());
 endmodule
