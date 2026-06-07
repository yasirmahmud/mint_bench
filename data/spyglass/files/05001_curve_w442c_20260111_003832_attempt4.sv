module curve_w442c_20260111_003832_attempt4 (
    input clk,
    input rst,
    input enable_reset, // Additional input to create a complex reset condition
    input d,
    output reg q
);

    always @(posedge clk or posedge rst) begin
        // W442c violation: The asynchronous reset condition 'rst && enable_reset'
        // is a logical expression, which is not a simple identifier or its negation.
        if (rst && enable_reset) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end

endmodule
