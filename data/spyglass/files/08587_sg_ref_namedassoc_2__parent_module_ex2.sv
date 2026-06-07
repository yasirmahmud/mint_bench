module parent_module_ex2;
 wire wa, wb, wc;
 assign wa = 1'b0;
 assign wb = 1'b1;
 child_module_ex2 inst_child (wa, wb, wc);
 endmodule
