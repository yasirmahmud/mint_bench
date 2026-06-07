module curve_stx_ve_483_20260110_165855_attempt12 (
    input wire clk,
    input wire rst,
    output reg out_val
);

    // STX_VE_483: The enum pragma must include a size (bit-width) specification
    // This localparam declaration uses a 'synopsys enum fsm' pragma but lacks the required
    // bit-width specification within the comment, e.g., '[1]' or '[2]'.
    localparam /* synopsys enum fsm */ STATE_ONE = 1'b0, STATE_TWO = 1'b1;

    reg current_state; // Implicitly 1-bit, no enum pragma here to avoid WRN_1023

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= STATE_ONE;
            out_val <= STATE_ONE;
        end else begin
            current_state <= (current_state == STATE_ONE) ? STATE_TWO : STATE_ONE;
            out_val <= current_state;
        end
    end

endmodule
