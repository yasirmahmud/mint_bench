module curve_stx_ve_483_20260112_000202_280747_w44756_attempt17 (
    input wire clk,
    input wire rst_n,
    input wire [1:0] mode_in,
    output wire [1:0] current_mode_out
);

    // STX_VE_483: This 'parameter' declaration uses a 'synopsys enum' pragma
    // but lacks the required bit-width specification within the comment,
    // e.g., '[2]' for 2 bits.
    parameter /* synopsys enum access_modes_t [2] */
        MODE_READ = 2'd0,
        MODE_WRITE = 2'd1,
        MODE_IDLE = 2'd2,
        MODE_CONFIG = 2'd3;

    reg [1:0] current_mode;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_mode <= MODE_IDLE;
        end else begin
            // Simple update logic to use the parameters to avoid unused parameter warnings
            case (mode_in)
                MODE_READ: current_mode <= MODE_READ;
                MODE_WRITE: current_mode <= MODE_WRITE;
                MODE_IDLE: current_mode <= MODE_IDLE;
                MODE_CONFIG: current_mode <= MODE_CONFIG;
                default: current_mode <= MODE_IDLE;
            endcase
        end
    end

    assign current_mode_out = current_mode;

endmodule
