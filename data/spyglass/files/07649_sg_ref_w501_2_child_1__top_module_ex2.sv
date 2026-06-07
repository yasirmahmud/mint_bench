module top_module_ex2;
 parameter RESET_VAL = 1'b0;
 child_module inst_child (.rst(RESET_VAL));
 endmodule
