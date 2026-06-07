module curve_starc05_2_11_3_1_20260111_141940_attempt4 (
    input wire clk,
    input wire rst_n,
    input wire start_i,
    input wire data_valid_i,
    output reg done_o
);

// Define FSM states using localparam
localparam [1:0] S0 = 2'b00;
localparam [1:0] S1 = 2'b01;
localparam [1:0] S2 = 2'b10;

// FSM state register
reg [1:0] current_state;

// This always block describes both the combinational next-state logic (determining the
// next state based on current_state and inputs) and the sequential state update
// (assigning to current_state with non-blocking assignments).
// This mixing of combinational and sequential parts of an FSM within
// the same clocked always block triggers STARC05-2.11.3.1.
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        current_state <= S0; // Reset to initial state
        done_o <= 1'b0;      // Reset output
    end else begin
        // The following case statement represents the combinational next-state logic,
        // while the non-blocking assignments update the state sequentially.
        case (current_state)
            S0: begin
                if (start_i) begin
                    current_state <= S1;
                    done_o <= 1'b0;
                end else begin
                    current_state <= S0;
                    done_o <= 1'b0;
                end
            end
            S1: begin
                if (data_valid_i) begin
                    current_state <= S2;
                    done_o <= 1'b0;
                end else begin
                    current_state <= S1;
                    done_o <= 1'b0;
                end
            end
            S2: begin
                current_state <= S0; // Transition back to S0
                done_o <= 1'b1;      // Set done_o high for one cycle in S2
            end
            default: begin // Default case for unknown states
                current_state <= S0;
                done_o <= 1'b0;
            end
        endcase
    end
end

endmodule
