module curve_stx_ve_483_20260110_165855_attempt13 (
    input wire clk,
    input wire rst,
    output reg state_out
);

    // STX_VE_483: The enum pragma must include a size (bit-width) specification
    // This parameter declaration uses a 'synopsys enum fsm' pragma but lacks the required
    // bit-width specification within the comment, e.g., '[1]' or '[2]'.
    parameter /* synopsys enum fsm */
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10;

    // The state register is explicitly sized to avoid WRN_1023 and other issues.
    reg [1:0] current_fsm_state;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_fsm_state <= STATE_A;
            state_out <= 1'b0;
        end else begin
            case (current_fsm_state)
                STATE_A: begin
                    current_fsm_state <= STATE_B;
                    state_out <= 1'b0;
                end
                STATE_B: begin
                    current_fsm_state <= STATE_C;
                    state_out <= 1'b1;
                end
                STATE_C: begin
                    current_fsm_state <= STATE_A;
                    state_out <= 1'b0;
                end
                default: begin
                    current_fsm_state <= STATE_A; // Handle unexpected state
                    state_out <= 1'b0;
                end
            endcase
        end
    end

endmodule
