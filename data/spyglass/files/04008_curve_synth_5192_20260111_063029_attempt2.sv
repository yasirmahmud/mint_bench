module curve_synth_5192_20260111_063029_attempt2 (
    input clk,
    input rst, // Reset signal
    input d,
    output reg q
);

// SYNTH_5192: Signal edge of "rst" used in condition of if statement does not match that specified in the sensitivity list of always block
// The sensitivity list expects an active-low asynchronous reset (negedge rst).
// However, the 'if' condition checks for 'rst' being high (active-high logic level).
// This mismatch triggers SYNTH_5192.
always @(posedge clk or negedge rst) begin
    if (rst) begin // Violation: Sensitivity list has 'negedge rst', but the condition 'if (rst)' checks for rst == 1 (a positive logic level).
        q <= 1'b0;
    end else begin
        q <= d;
    end
end

endmodule
