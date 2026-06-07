module top_module_ex2;
 wire regular_driver_sig;
 assign regular_driver_sig = 1'b1;
 child_module u_child (.out_port(regular_driver_sig));
 initial force u_child.out_port = 1'b0;
 endmodule
