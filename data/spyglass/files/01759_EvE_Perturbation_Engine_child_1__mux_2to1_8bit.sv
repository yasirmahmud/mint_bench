// Define mux_2to1_8bit module (resolves ErrorAnalyzeBBox for 'mux_2to1_8bit')
module mux_2to1_8bit (
    input [7:0] a,
    input [7:0] b,
    input select,
    output [7:0] out
);
    assign out = select ? a : b;
endmodule
