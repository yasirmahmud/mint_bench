module child_module_ex1 (input [3:0] data_in);
    // Added a dummy assignment to resolve WarnAnalyzeBBox (empty module) and W240 (unused input).
    // This ensures 'data_in' is read internally without affecting external behavior.
    wire [3:0] dummy_data_capture;
    assign dummy_data_capture = data_in;
endmodule
