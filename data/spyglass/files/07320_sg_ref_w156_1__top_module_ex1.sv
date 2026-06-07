module top_module_ex1 ();
 wire [0:3] my_bus;
 assign my_bus = 4'b0;
 child_module_ex1 u_child (.data_in(my_bus));
 endmodule
