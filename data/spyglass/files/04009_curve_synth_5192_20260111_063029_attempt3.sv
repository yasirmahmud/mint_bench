module curve_synth_5192_20260111_063029_attempt3 (
    input clk,
    input rst, // Reset signal
    input d,
    output reg q
);

// SYNTH_5192: Signal edge of "rst" used in condition of if statement does not match that specified in the sensitivity list of always block
always @(posedge clk or posedge rst) begin
    // Violation: The sensitivity list specifies an active-high asynchronous reset (posedge rst),
    // but the 'if' condition checks for 'rst' being low (active-low logic level, !rst).
    // This mismatch triggers SYNTH_5192.
    if (!rst) begin 
        q <= 1'b0; // Reset state
    end else begin
        q <= d;
    end
end

endmodule
