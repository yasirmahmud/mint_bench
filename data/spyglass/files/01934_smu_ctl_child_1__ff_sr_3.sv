// 3-bit Synchronous Reset Flip-Flop
module ff_sr_3 (
    output reg [2:0] out,
    input [2:0] din,
    input clk,
    input reset_l
);
    always @(posedge clk or negedge reset_l) begin
        if (!reset_l) begin
            out <= 3'b0;
        end else begin
            out <= din;
        end
    end
endmodule
