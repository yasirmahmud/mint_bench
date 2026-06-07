module top_module_ex1;
 wire data_in;
 child_module_ex1 u_child (.data_in(data_in));
 assign data_in = 1'b0;
 endmodule
