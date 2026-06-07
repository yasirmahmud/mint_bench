module sub_module_ex1 (input [3:0] data_in);
    // Fix W240: Input 'data_in' declared but not read.
    // Fix WarnAnalyzeBBox: Design unit has empty definition.
    wire [3:0] data_in_read;
    assign data_in_read = data_in;
endmodule
