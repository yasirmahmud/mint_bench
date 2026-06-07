module curve_starc05_2_11_3_1_20260111_141940_attempt5 (
    input wire clk,
    input wire rst_n,
    input wire data_in,
    output reg sequence_found_o
);

// FSM state definitions
localparam [1:0] IDLE        = 2'b00;
localparam [1:0] S1_DETECTED = 2'b01; // First '1' detected
localparam [1:0] S0_DETECTED = 2'b10; // Sequence '10' detected

// FSM state register
reg [1:0] current_state;

// This always block describes both the combinational next-state logic (determining the
// next state based on current_state and inputs) and the sequential state update
// (assigning to current_state with non-blocking assignments). This mixing of
// combinational and sequential parts of an FSM within the same clocked always block
// triggers STARC05-2.11.3.1.
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        // Asynchronous reset to initial state
        current_state <= IDLE;
        sequence_found_o <= 1'b0;
    end else begin
        // Default output to prevent unintended latches
        sequence_found_o <= 1'b0;

        // The case statement defines the combinational next-state logic,
        // and non-blocking assignments update the state sequentially.
        case (current_state)
            IDLE: begin
                if (data_in == 1'b1) begin
                    current_state <= S1_DETECTED;
                end else begin
                    current_state <= IDLE;
                end
            end
            S1_DETECTED: begin
                if (data_in == 1'b0) begin
                    current_state <= S0_DETECTED; // '10' sequence complete
                end else begin // data_in == 1'b1, stay in S1_DETECTED to check for '1' then '0'
                    current_state <= S1_DETECTED;
                end
            end
            S0_DETECTED: begin
                // Sequence '10' was detected in the previous cycle, pulse output
                sequence_found_o <= 1'b1;
                // Transition to look for the next sequence (allows overlapping if data_in is '1')
                if (data_in == 1'b1) begin
                    current_state <= S1_DETECTED;
                end else begin
                    current_state <= IDLE;
                end
            end
            default: begin
                current_state <= IDLE; // Handle unexpected states by returning to IDLE
                sequence_found_o <= 1'b0;
            end
        endcase
    end
end

endmodule
