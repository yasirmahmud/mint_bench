module SPIBR (
    input  wire [7:0] SPIBR_in,
    input  wire       clk,
    input  wire       rst,
    output wire [2:0] SPR
);
    // W240: Dummy use of inputs
    assign SPR = (SPIBR_in[2:0] ^ {clk, rst, clk}) & ~rst;
endmodule
