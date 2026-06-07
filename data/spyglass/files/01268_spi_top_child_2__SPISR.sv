module SPISR (
    input  wire clk,
    input  wire rst,
    input  wire en,
    input  wire SPISR_in,
    output wire SPIF
);
    // W240: Dummy use of inputs
    assign SPIF = SPISR_in & en & clk & ~rst;
endmodule
