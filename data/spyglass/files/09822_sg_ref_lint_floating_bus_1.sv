module LINT_FLOATING_BUS_ex1;
 wire my_bus;
 reg sel1, sel2;
 assign my_bus = sel1 ? 1'b1 : 1'bz;
 assign my_bus = sel2 ? 1'b0 : 1'bz;
 endmodule
