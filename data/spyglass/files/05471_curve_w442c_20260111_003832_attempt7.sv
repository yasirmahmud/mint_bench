module curve_w442c_20260111_003832_attempt7 (
    input clk,
    input rst,
    input d,
    output reg q
);

    // Define a local function that abstracts the reset condition.
    // SpyGlass expects the asynchronous reset condition to be a simple identifier
    // or its negation directly in the 'if' statement.
    function is_active_reset(input rst_signal);
        begin
            // This function simply returns its input, mimicking an active-high reset.
            is_active_reset = rst_signal;
        end
    endfunction

    // W442c violation: The asynchronous reset condition in this always block
    // is a function call, 'is_active_reset(rst)', which is not a simple
    // identifier ('rst') or its negation ('!rst' or '~rst').
    always @(posedge clk or posedge rst) begin
        if (is_active_reset(rst)) begin // This condition triggers W442c
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end

endmodule
