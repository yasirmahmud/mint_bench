module curve_w442c_20260111_003832_attempt7 (
    input clk,
    input rst,
    input d,
    output reg q
);

    // W442c violation: The asynchronous reset condition in this always block
    // was previously a function call. It has been replaced with a simple
    // identifier 'rst' to resolve the violation, maintaining active-high reset behavior.
    always @(posedge clk or posedge rst) begin
        if (rst) begin // Fixed W442c: Changed from 'is_active_reset(rst)' to 'rst'
            q <= 1'b0;
        end else begin
            q <= d;
        }
    end

endmodule
