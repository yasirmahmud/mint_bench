module child_ex1 (
    input  [3:0] data_in,
    output [3:0] data_out
);
    assign data_out = data_in; // Reads data_in and provides an output, resolving W240 and WarnAnalyzeBBox
endmodule
