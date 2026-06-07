module curve_w442c_20260111_003832_attempt5 (
    input clk,
    input rst,
    input d,
    output reg q
);

    // Function to encapsulate the reset signal. 
    // SpyGlass will analyze the 'if' condition directly.
    function is_reset_active(input reset_signal);
        begin
            is_reset_active = reset_signal;
        end
    endfunction

    always @(posedge clk or posedge rst) begin
        // W442c violation: The asynchronous reset condition 'is_reset_active(rst)'
        // is a function call, which is not considered a "simple identifier or its negation".
        if (is_reset_active(rst)) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end

endmodule
