module curve_stx_ve_483_20260112_000202_280747_w44756_attempt16 (
    input wire clk,
    input wire rst_n,
    output wire [1:0] out_val
);

    // STX_VE_483: The 'synopsys enum' pragma on the following line lacks
    // the required bit-width specification, e.g., '[2]', within the comment.
    localparam /* synopsys enum status_t */
        STATUS_INIT = 2'd0,
        STATUS_READY = 2'd1,
        STATUS_BUSY = 2'd2,
        STATUS_DONE = 2'd3;

    reg [1:0] current_status;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_status <= STATUS_INIT;
        end else begin
            // Use the localparams to avoid unused parameter warnings
            case (current_status)
                STATUS_INIT: current_status <= STATUS_READY;
                STATUS_READY: current_status <= STATUS_BUSY;
                STATUS_BUSY: current_status <= STATUS_DONE;
                STATUS_DONE: current_status <= STATUS_INIT;
                default: current_status <= STATUS_INIT;
            endcase
        end
    end

    assign out_val = current_status;

endmodule
