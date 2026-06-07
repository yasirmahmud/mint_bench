module curve_starc05_2_2_3_3_20260111_154605_205081_w31260_attempt4 (
    input wire clk,
    input wire reset,
    input wire data_in_a,
    input wire data_in_b,
    output reg buffer_full
);

// Minimal sequential block to demonstrate the violation
always @(posedge clk or posedge reset) begin
    if (reset) begin
        buffer_full <= 1'b0;
    end else begin
        // First assignment to buffer_full
        buffer_full <= data_in_a;

        // STARC05-2.2.3.3 violation: The flip-flop 'buffer_full' is assigned
        // again within the same sequential always block's scope. This constitutes
        // being "assigned over the same signal". Although in simulation the last
        // assignment wins, synthesis and linting tools often flag such redundant
        // or multiple assignments as a violation of design clarity and potential
        // for unintended behavior or synthesis issues.
        buffer_full <= data_in_b;
    end
end

endmodule
