module top_module_ex2 ();
 wire unused_out_port; // Added to resolve W287b violation
 child_module_ex2 u_child_ex2 (.out_port (unused_out_port));
 endmodule
