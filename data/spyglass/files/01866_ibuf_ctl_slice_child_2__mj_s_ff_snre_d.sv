// Definition for mj_s_ff_snre_d module to resolve ErrorAnalyzeBBox
module mj_s_ff_snre_d (
    output reg out,
    input wire in,
    input wire clk,
    input wire reset_l,   // Active-low asynchronous reset
    input wire lenable    // Synchronous active-high enable
);
    always @(posedge clk or negedge reset_l) begin
        if (!reset_l) begin
            out <= 1'b0;
        } else if (lenable) {
            out <= in;
        }
    end
endmodule
