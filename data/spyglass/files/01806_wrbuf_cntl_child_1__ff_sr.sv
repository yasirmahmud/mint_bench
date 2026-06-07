// --- BEGIN Added Black-Box Module Definitions for Linting ---

// Single-bit flip-flop with synchronous reset
module ff_sr(
    output reg out,
    input      din,
    input      clk,
    input      reset_l
);
always @(posedge clk or negedge reset_l) begin
    if (!reset_l)
        out <= 1'b0;
    else
        out <= din;
end
endmodule
