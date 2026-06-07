module parent_module_ex2;
 wire wa, wb, wc;
 assign wa = 1'b0;
 assign wb = 1'b1;
 child_module_ex2 inst_child (.a(wa), .b(wb), .c(wc)); // Connected 'c' port to an unused wire 'wc' to resolve W287b
endmodule
