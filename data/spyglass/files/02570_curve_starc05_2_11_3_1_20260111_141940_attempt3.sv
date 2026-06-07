module curve_starc05_2_11_3_1_20260111_141940_attempt3 (
    input wire clk,
    input wire rst_n,
    input wire trigger_i,
    output reg state_out_q
);

parameter STATE_IDLE = 1'b0;
parameter STATE_ACTIVE = 1'b1;

reg current_state; // FSM state register

// This always block describes both the combinational next-state logic (determining the
// next state based on current_state and inputs) and the sequential state update
// (assigning to current_state with non-blocking assignments).
// This mixing of combinational and sequential parts of an FSM within
// the same clocked always block triggers STARC05-2.11.3.1.
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        current_state <= STATE_IDLE; // Reset to initial state
        state_out_q <= 1'b0;
    end else begin
        // The following if-else if structure represents the combinational next-state logic
        // based on current_state, while the non-blocking assignments represent the sequential update.
        if (current_state == STATE_IDLE) begin
            if (trigger_i) begin
                current_state <= STATE_ACTIVE; // Sequential update
                state_out_q <= 1'b1; // Output associated with active state
            end else begin
                current_state <= STATE_IDLE;   // Sequential update
                state_out_q <= 1'b0; // Output associated with idle state
            end
        end else if (current_state == STATE_ACTIVE) begin
            current_state <= STATE_IDLE;    // Unconditional transition back to IDLE
            state_out_q <= 1'b0; // Output goes back to 0
        end else begin // Default case for unknown states
            current_state <= STATE_IDLE;    // Sequential update
            state_out_q <= 1'b0;
        end
    end
end

endmodule
