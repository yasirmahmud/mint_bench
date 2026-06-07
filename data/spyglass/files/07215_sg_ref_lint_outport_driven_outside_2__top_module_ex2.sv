module top_module_ex2 ();
 wire conflicting_net;
 child_module_ex2 u_child_ex2 (.out_port (conflicting_net));
 assign conflicting_net = 1'b1;
 endmodule
