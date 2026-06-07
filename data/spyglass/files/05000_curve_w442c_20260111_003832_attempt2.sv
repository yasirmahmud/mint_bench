module curve_w442c_20260111_003832_attempt2 (
    input clk,
    input rst,
    input enable_reset,
    input d,
    output reg q
);

always @(posedge clk or posedge rst) begin
    // W442c violation: The asynchronous reset condition 'rst && enable_reset'
    // is a complex boolean expression, not a simple identifier or its negation.
    if (rst && enable_reset) begin
        q <= 1'b0;
    end else begin
        q <= d;
    end
end

endmodule
