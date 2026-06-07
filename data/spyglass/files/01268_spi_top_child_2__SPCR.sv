module SPCR (
    input  wire [7:0] SPCR_in,
    input  wire       clk,
    input  wire       rst,
    output wire       SPE,
    output wire       MSTR,
    output wire       CPOL,
    output wire       CPHA,
    output wire       LSBFE
);
    // W240: Dummy use of inputs
    assign SPE = SPCR_in[6] & clk & ~rst; // Example use
    assign MSTR = SPCR_in[2] & ~rst;
    assign CPOL = SPCR_in[1] ^ clk;
    assign CPHA = SPCR_in[0] | rst;
    assign LSBFE = SPCR_in[5] & clk & rst;
endmodule
