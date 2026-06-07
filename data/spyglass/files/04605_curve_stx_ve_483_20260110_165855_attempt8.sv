module curve_stx_ve_483_20260110_165855_attempt8 (
    input wire clk,
    input wire rst_n,
    output reg [1:0] state_out
);

    // STX_VE_483: The enum pragma must include a size (bit-width) specification
    // This 'reg' declaration uses a 'synopsys enum' pragma but lacks the required 
    // bit-width specification within the comment, e.g., '[2]'.
    // The 'reg' itself has an explicit width [1:0], which is good practice and
    // should prevent WRN_1023 or similar width-related warnings on the 'reg' itself,
    // while the pragma's lack of internal width specification triggers STX_VE_483.
    reg [1:0] /* synopsys enum state_type */ current_state;

    // Define states using localparam with explicit widths to avoid other potential warnings.
    localparam [1:0] S_IDLE = 2'b00;
    localparam [1:0] S_RUN  = 2'b01;
    localparam [1:0] S_DONE = 2'b10;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= S_IDLE;
            state_out <= S_IDLE;
        end else begin
            case (current_state)
                S_IDLE: begin
                    current_state <= S_RUN;
                    state_out <= S_RUN;
                end
                S_RUN: begin
                    current_state <= S_DONE;
                    state_out <= S_DONE;
                end
                S_DONE: begin
                    current_state <= S_IDLE;
                    state_out <= S_IDLE;
                end
                default: begin
                    current_state <= S_IDLE;
                    state_out <= S_IDLE;
                end
            endcase
        end
    end

endmodule
