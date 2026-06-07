// Single-bit flip-flop with set-on-reset behavior, matching wb_state[0]
module ff_s(
    output reg out,
    input      din,      // This is the data input when not resetting
    input      clk,
    input      reset_l
);
always @(posedge clk or negedge reset_l) begin
    if (!reset_l)      // Active low reset
        out <= 1'b1;    // Set to 1
    else
        out <= din;     // Otherwise, behave as a D-FF
end
endmodule
