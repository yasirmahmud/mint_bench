module curve_stx_ve_483_20260110_165855_attempt10 (n    input wire clk,
    input wire rst,
    output reg [1:0] state_out
);

    // STX_VE_483: The enum pragma must include a size (bit-width) specification
    // This 'parameter' declaration uses a 'synopsys enum' pragma but lacks the required
    // bit-width specification within the comment, e.g., '[1]' or '[2]'.
    parameter /* synopsys enum [2] system_modes */
        MODE_IDLE   = 2'b00,
        MODE_ACTIVE = 2'b01,
        MODE_SLEEP  = 2'b10;

    // A simple always block to use the defined parameters and avoid unused warnings
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state_out <= MODE_IDLE;
        end else begin
            case (state_out)
                MODE_IDLE: state_out <= MODE_ACTIVE;
                MODE_ACTIVE: state_out <= MODE_SLEEP;
                MODE_SLEEP: state_out <= MODE_IDLE;
                default: state_out <= MODE_IDLE; // Defensive default
            endcase
        end
    end

endmodule
