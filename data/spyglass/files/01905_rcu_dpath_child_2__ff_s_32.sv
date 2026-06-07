// ff_s_32 (Standard Flip-flop)
module ff_s_32 (
    input [31:0] din,
    input clk,
    output reg [31:0] out
);
    always @(posedge clk) begin
        out <= din;
    end
endmodule
