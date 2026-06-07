module sub_module_ex1 (
    input [3:0] data_in,
    output [3:0] data_out // Added output to make data_in 'read' and module 'not empty'
);
    // Resolves W240 (Input 'data_in' declared but not read) by using data_in.
    // Resolves WarnAnalyzeBBox (Design unit has empty definition) by having an assignment.
    // Resolves W528 (Variable 'data_in_read[3:0]' set but not read) by removing the unused 'data_in_read' and assigning directly to an output.
    assign data_out = data_in;
endmodule
