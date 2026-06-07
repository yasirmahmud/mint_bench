module parent_module_ex2;
 wire wa, wb;
 assign wa = 1'b0;
 assign wb = 1'b1;
 child_module_ex2 inst_child (.a(wa), .b(wb)); // Changed to named association, 'c' port left unconnected as 'wc' was unused
endmodule
