module curve_stx_ve_483_20260110_165855_attempt6 (
    input wire clk,
    input wire rst,
    input wire in_val,
    output reg out_val
);

    // STX_VE_483: The enum pragma must include a size (bit-width) specification
    // This parameter declaration uses /* synopsys enum ... */ without specifying a size like [1]
    parameter /* synopsys enum state_encoding [0:0] */ STATE_IDLE = 1'b0, STATE_ACTIVE = 1'b1;

    // State register with explicit width and no enum pragma to avoid other violations
    reg [0:0] current_state;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= STATE_IDLE;
            out_val <= 1'b0;
        end else begin
            case (current_state)
                STATE_IDLE: begin
                    if (in_val) begin
                        current_state <= STATE_ACTIVE;
                    end
                    out_val <= 1'b0;
                end
                STATE_ACTIVE: begin
                    current_state <= STATE_IDLE;
                    out_val <= in_val;
                end
                default: begin
                    // Ensure all states are covered to avoid unintended latches
                    current_state <= STATE_IDLE;
                    out_val <= 1'b0;
                end
            endcase
        end
    end

endmodule
