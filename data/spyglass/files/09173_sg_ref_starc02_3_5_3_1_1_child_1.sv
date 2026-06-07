////////////////////////////////////////////////////
// FILE NAME : test_ex1.v
// FUNCTION : Example module
// CREATION DATE : 2023-01-01
/////////////////////////////////////////////////////
module test_ex1 (
    input clk,
    input rst_n,
    input [7:0] data_in,
    output [7:0] data_out
);

    // Added dummy ports and a simple assignment to satisfy STARC02-3.5.3.1
    // and ensure SpyGlass recognizes a valid top-level design unit.
    assign data_out = data_in;

endmodule
