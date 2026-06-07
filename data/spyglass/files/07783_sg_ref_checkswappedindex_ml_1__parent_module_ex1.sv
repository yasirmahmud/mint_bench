module parent_module_ex1;
 wire [0:3] my_bus;
 assign my_bus = 4'b0;
 child_module_ex1 inst_ex1 (.data_in(my_bus));
 endmodule
