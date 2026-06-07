module HierarchicalFunctionTask_ML_ex1;
    sub_module sub_inst();
    
    // Changed 'reg' to 'wire' and used continuous assignment
    // to make the assignment synthesizable and resolve W528 and SYNTH_5143.
    wire [7:0] data;
    assign data = sub_inst.my_func(5);

endmodule
