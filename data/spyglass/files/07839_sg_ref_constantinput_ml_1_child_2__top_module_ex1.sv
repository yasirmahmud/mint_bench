module top_module_ex1 ();
 // The 'my_signal' wire was previously set but not read, causing a W528 violation.
 // To resolve this without changing the functional behavior of top_module_ex1
 // (which did not use 'my_signal'), the 'out_z' port of u_sub_ex1 is now
 // explicitly left unconnected. This effectively removes the unused signal.
 //
 // To resolve W287b (unconnected output port) while preserving the original intent
 // that 'out_z' is not used by top_module_ex1, we connect it to a local dummy wire.
 wire unused_out_z;
 sub_module_ex1 u_sub_ex1 (.in_a (1'b1), .out_z (unused_out_z));
 endmodule
