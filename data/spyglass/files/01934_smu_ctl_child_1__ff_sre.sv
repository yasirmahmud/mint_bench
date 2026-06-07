// Synchronous Reset Flip-Flop with Enable
module ff_sre (
    output reg out,
    input din,
    input clk,
    input reset_l,
    input enable
);
    always @(posedge clk or negedge reset_l) begin
        if (!reset_l) begin
            out <= 1'b0;
        end else if (enable) begin
            out <= din;
        end
    end
endmodule
