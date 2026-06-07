// Dummy module definitions to resolve ErrorAnalyzeBBox violations and linting warnings

module BRG #(
    parameter PrescalarWidth = 3
) (
    input  wire clk,
    input  wire rst,
    input  wire clr,
    input  wire [PrescalarWidth-1:0] SPR,
    output wire BaudRate
);
    // W240: Dummy use of inputs
    assign BaudRate = clk & rst & clr & SPR[0] & 1'b1;
endmodule
