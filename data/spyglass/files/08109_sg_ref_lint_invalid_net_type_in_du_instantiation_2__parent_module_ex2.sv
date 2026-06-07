module parent_module_ex2 ();
 wire connect_wire;
 child_module u_child (.in_a(1'b0), .out_reg(connect_wire));
 endmodule
