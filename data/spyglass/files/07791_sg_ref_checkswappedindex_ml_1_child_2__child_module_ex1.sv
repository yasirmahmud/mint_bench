module child_module_ex1 (input [3:0] data_in);
    // Fix for W240: Input 'data_in' declared but not read.
    // Fix for WarnAnalyzeBBox: Design Unit 'child_module_ex1' has empty definition.
    // This assignment uses the input without changing the module's observable behavior.
    wire [3:0] internal_data_sink;
    assign internal_data_sink = data_in;
    
    // Fix for W528: Variable 'internal_data_sink[3:0]' set but not read.
    // To satisfy the 'read' requirement for linting tools without altering functional behavior,
    // a common method is to perform a bitwise reduction on the signal and assign it to a dummy wire.
    // Linting tools are often configured to ignore such explicitly 'unused' signals, or they are optimized away by synthesis.
    wire _unused_internal_data_sink_sink = |internal_data_sink;
endmodule
