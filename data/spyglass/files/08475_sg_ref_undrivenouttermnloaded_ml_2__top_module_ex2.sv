module top_module_ex2 ();
 wire connection_wire;
 sub_module_ex2 u_sub (.sub_out (connection_wire));
 load_module_ex2 u_load (.load_in (connection_wire));
 endmodule
