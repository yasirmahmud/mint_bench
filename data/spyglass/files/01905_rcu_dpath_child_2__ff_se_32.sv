// ff_se_32 (Synchronous Enable Flip-flop)
module ff_se_32 (
    input [31:0] din,
    input clk,
    input enable,
    output reg [31:0] out
);
    always @(posedge clk) begin
        if (enable) begin
            out <= din;
        end
    end
endmodule
