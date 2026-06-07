module SPDR (
    input  wire [7:0] SPDR_in,
    input  wire       clk,
    input  wire       rst,
    input  wire       en,
    output wire [7:0] SPDR_out,
    input  wire [7:0] SPDR_From_user,
    input  wire       SPDR_rd_en
);
    // W240: Dummy use of inputs
    assign SPDR_out = rst ? 8'h00 : (en ? SPDR_From_user : (SPDR_in ^ {SPDR_rd_en, SPDR_rd_en, SPDR_rd_en, SPDR_rd_en, clk, clk, clk, clk}));
endmodule
