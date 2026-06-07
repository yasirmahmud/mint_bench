module parent_module_ex1;
    // Fix for W156: Bus net 'data_in' is connected in reverse.
    // Changed 'my_bus' from [0:3] to [3:0] to match 'data_in' declaration in child_module_ex1.
    wire [3:0] my_bus;
    assign my_bus = 4'b0;
    child_module_ex1 inst_ex1 (.data_in(my_bus));
endmodule
