module curve_w442c_20260111_003832_attempt3 (
    input clk,
    input rst,
    input d,
    output reg q
);

    // Function to wrap the reset signal, making the condition complex
    // (not a simple identifier or its negation)
    function reg get_reset_status(input r_in);
        get_reset_status = r_in;
    endfunction

    always @(posedge clk or posedge rst) begin
        // W442c violation: The asynchronous reset condition 'get_reset_status(rst)'
        // is a function call, which is not a simple identifier or its negation.
        if (get_reset_status(rst)) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end

endmodule
