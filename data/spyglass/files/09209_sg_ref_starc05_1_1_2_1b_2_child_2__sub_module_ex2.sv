module sub_module_ex2();
    // Added a dummy wire and assignment to resolve STARC05-1.1.2.1b empty module warning.
    // This preserves functional behavior as the module was originally empty.
    wire dummy_signal_to_avoid_empty_module_warning;
    assign dummy_signal_to_avoid_empty_module_warning = 1'b0;
 endmodule
