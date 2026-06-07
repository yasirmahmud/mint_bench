module parent_module_ex2;
 wire [15:0] child_out;
 child_module_ex2 #(.WIDTH(16)) u_child_instance (.out(child_out));
 endmodule
