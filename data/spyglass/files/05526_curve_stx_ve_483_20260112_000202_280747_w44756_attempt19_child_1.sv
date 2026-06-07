module curve_stx_ve_483_20260112_000202_280747_w44756_attempt19 (
    input wire clk,
    input wire rst_n,
    input wire [1:0] data_in,
    output wire [1:0] data_out
);

    // STX_VE_483: This 'parameter' declaration uses a 'synopsys enum' pragma
    // but lacks the required bit-width specification within the comment,
    // e.g., '[2]' for a 2-bit enum. This is the intended violation.
    // The individual constants are explicitly sized to avoid other warnings.
    parameter /* synopsys enum signal_levels [2] */
        LEVEL_LOW  = 2'd0,
        LEVEL_MED  = 2'd1,
        LEVEL_HIGH = 2'd2;

    reg [1:0] current_level;
    reg [1:0] next_level;

    // Minimal FSM to use the enum parameters and avoid unused parameter warnings
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_level <= LEVEL_LOW;
        end else begin
            current_level <= next_level;
        end
    end

    always @(*) begin
        next_level = current_level; // Default to self-loop

        case (data_in) // Use data_in to drive state changes
            LEVEL_LOW: begin
                next_level = LEVEL_MED;
            end
            LEVEL_MED: begin
                next_level = LEVEL_HIGH;
            end
            LEVEL_HIGH: begin
                next_level = LEVEL_LOW;
            end
            default: begin
                // Handle out-of-range data_in values to avoid latches
                next_level = current_level;
            end
        endcase
    end

    assign data_out = current_level;

endmodule
