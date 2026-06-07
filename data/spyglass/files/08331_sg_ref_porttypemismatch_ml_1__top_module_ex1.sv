module top_module_ex1;
 reg my_reg;
 sub_module_ex1 u_sub_module_ex1 (.in_port(my_reg));
 initial my_reg = 1'b0;
 endmodule
