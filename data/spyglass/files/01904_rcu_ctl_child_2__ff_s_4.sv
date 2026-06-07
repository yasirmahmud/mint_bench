// Dummy module for ff_s_4 (4-bit flop, no reset)
module ff_s_4 (
    output reg [3:0] out,
    input [3:0] din,
    input clk
);
    always @(posedge clk) begin
        out <= din;
    end
endmodule
