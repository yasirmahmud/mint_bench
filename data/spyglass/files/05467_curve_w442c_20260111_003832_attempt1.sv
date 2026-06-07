module curve_w442c_20260111_003832_attempt1 (
    input clk,
    input rst,
    input d,
    output reg q
);

// Function to encapsulate reset logic
function [0:0] get_reset_active_state;
    input rst_signal;
    begin
        // In a real design, this function might contain complex logic.
        // For this example, it simply passes through the signal.
        get_reset_active_state = rst_signal;
    end
endfunction

always @(posedge clk or posedge rst) begin
    // W442c violation: The asynchronous reset condition 'get_reset_active_state(rst)'
    // is a function call, not a simple identifier or its negation.
    if (get_reset_active_state(rst)) begin
        q <= 1'b0;
    end else begin
        q <= d;
    end
end

endmodule
