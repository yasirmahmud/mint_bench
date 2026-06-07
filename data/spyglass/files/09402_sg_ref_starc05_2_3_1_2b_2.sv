module my_module_ex2;
 reg my_reg;
 initial begin assign my_reg = 1'b0;
 #1 deassign my_reg;
 end endmodule
