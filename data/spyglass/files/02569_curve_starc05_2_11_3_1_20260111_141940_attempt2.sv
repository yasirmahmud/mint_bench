module curve_starc05_2_11_3_1_20260111_141940_attempt2 (
    input wire clk,
    input wire rst_n,
    input wire start_i,
    output reg done_o
);

// FSM states
parameter S_IDLE = 2'b00;
parameter S_STATE_A = 2'b01;
parameter S_STATE_B = 2'b10;

reg [1:0] current_state; // State register

// This always block describes both the combinational next-state logic
// (determining the next state based on current_state and inputs)
// and the sequential state update (assigning to current_state with non-blocking assignments).
// This mixing of combinational and sequential parts of an FSM within
// the same clocked always block triggers STARC05-2.11.3.1.
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        current_state <= S_IDLE; // Reset to IDLE
        done_o <= 1'b0;
    end else begin
        case (current_state) // This 'case' statement implements the combinational next-state logic
            S_IDLE: begin
                if (start_i) begin
                    current_state <= S_STATE_A; // Sequential update
                    done_o <= 1'b0;
                end else begin
                    current_state <= S_IDLE;    // Sequential update
                    done_o <= 1'b0;
                end
            end
            S_STATE_A: begin
                current_state <= S_STATE_B;     // Sequential update
                done_o <= 1'b0;
            end
            S_STATE_B: begin
                current_state <= S_IDLE;        // Sequential update
                done_o <= 1'b1;
            end
            default: begin
                current_state <= S_IDLE;        // Sequential update
                done_o <= 1'b0;
            end
        endcase
    end
end

endmodule
