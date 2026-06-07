// 4-bit Synchronous Reset Flip-Flop
module ff_sr_4 (
    output reg [3:0] out,
    input [3:0] din,
    input clk,
    input reset_l
);
    always @(posedge clk or negedge reset_l) begin
        if (!reset_l) begin
            out <= 4'b0;
        end else begin
            out <= din;
        end
    end
endmodule
