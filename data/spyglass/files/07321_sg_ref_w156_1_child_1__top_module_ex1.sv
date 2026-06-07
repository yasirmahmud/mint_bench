module top_module_ex1 ();
 wire [3:0] my_bus; // Changed from [0:3] to [3:0] to resolve W156 for bus direction consistency.
 assign my_bus = 4'b0;
 child_module_ex1 u_child (.data_in(my_bus));
 endmodule
