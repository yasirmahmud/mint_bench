// Sub-module definition for debouncer_delayed_fsm
// Implements a two-state FSM to control the debouncing process.
// S_IDLE: The debounced output is stable. Monitors noisy input for changes.
// S_WAIT: Noisy input has changed. Starts a timer and waits for the noisy input
//         to remain stable for the timer's duration. If noisy flickers, timer resets.
module debouncer_delayed_fsm (
    input clk,
    input reset_n,
    input noisy,
    input timer_done,
    output reg timer_reset, // Active high: reset/disable timer; Active low: enable timer
    output reg debounced
);

// FSM states
localparam S_IDLE  = 2'b00; // Debounced output is stable, timer is reset/disabled
localparam S_WAIT  = 2'b01; // Noisy input changed, timer is enabled and counting

reg [1:0] current_state, next_state;

// This register stores the value of 'noisy' that the FSM is currently waiting
// for the timer to confirm as stable.
reg noisy_at_transition;

// Sequential logic for state register and debounced output
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        current_state <= S_IDLE;
        debounced <= 1'b0; // Default reset value for debounced output
        noisy_at_transition <= 1'b0; // Reset the expected stable value
    end else begin
        current_state <= next_state;
        // The debounced output is updated only when the FSM is transitioning
        // from S_WAIT to S_IDLE due to the timer expiring.
        if (current_state == S_WAIT && timer_done) begin
            debounced <= noisy_at_transition;
        end
    end
end

// Combinational logic for next state and output signals (like timer_reset)
always @(*) begin
    next_state = current_state;
    timer_reset = 1'b1; // Default to resetting/disabling timer (active high)

    case (current_state) // Evaluate based on current state
        S_IDLE: begin
            if (noisy != debounced) begin
                next_state = S_WAIT;
                timer_reset = 1'b0; // Enable timer (active low)
                noisy_at_transition = noisy; // Capture the new noisy value to debounce
            end else begin
                // If debounced already matches noisy, timer remains reset/disabled
                timer_reset = 1'b1; // Explicitly ensure timer is reset/disabled
            end
        end
        S_WAIT: begin
            if (noisy != noisy_at_transition) begin
                // Noise flickered back to original (or another) value, abort and restart wait
                next_state = S_IDLE;
                timer_reset = 1'b1; // Reset timer (active high)
            end else if (timer_done) begin
                // Noise remained stable for the WAIT period, debounce complete
                next_state = S_IDLE;
                timer_reset = 1'b1; // Reset timer (active high)
                // 'debounced' output will be updated in the sequential block on the next clock edge
            end else begin
                // Still waiting for timer to expire and noisy to remain stable
                timer_reset = 1'b0; // Keep timer running (active low)
            end
        end
        default: begin // Default case for unexpected states (e.g., during reset or power-up)
            next_state = S_IDLE;
            timer_reset = 1'b1;
        end
    endcase
end

endmodule
