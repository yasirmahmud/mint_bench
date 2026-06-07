module child_module_ex1 (input [3:0] data_in);
    // Fix for W240: Input 'data_in' declared but not read.
    // Fix for WarnAnalyzeBBox: Design Unit 'child_module_ex1' has empty definition.
    // This assignment uses the input without changing the module's observable behavior.
    wire [3:0] internal_data_sink;
    assign internal_data_sink = data_in;
endmodule
