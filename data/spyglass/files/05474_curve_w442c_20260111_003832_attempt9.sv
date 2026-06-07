module curve_w442c_20260111_003832_attempt9 (
    input clk,
    input rst, // Active-high asynchronous reset
    input d,
    output reg q
);

    // Define a function that determines if reset is active.
    // The use of this function as the reset condition will trigger W442c.
    function automatic is_reset_active (input rst_signal);
        case (rst_signal)
            1'b1: is_reset_active = 1'b1;
            default: is_reset_active = 1'b0;
        endcase
    endfunction

    // W442c violation: The asynchronous reset condition in this always block
    // uses a function call `is_reset_active(rst)`, which is not a simple
    // identifier (`rst`) or its negation (`!rst` or `~rst`).
    always @(posedge clk or posedge rst) begin
        if (is_reset_active(rst)) begin // This condition triggers W442c
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end

endmodule
