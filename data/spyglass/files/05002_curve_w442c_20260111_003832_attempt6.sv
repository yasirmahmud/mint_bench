module curve_w442c_20260111_003832_attempt6 (
    input clk,
    input rst,
    input enable_async_reset, // Added to create a complex reset condition
    input d,
    output reg q
);

    // W442c violation: The asynchronous reset/set condition in an always block
    // must be a simple identifier (e.g., 'rst') or its negation (! or ~).
    // Here, the condition is a logical expression 'rst && enable_async_reset',
    // which is not considered a simple identifier or its negation.
    // The asynchronous reset signal from the sensitivity list is 'rst'.
    always @(posedge clk or posedge rst) begin
        if (rst && enable_async_reset) begin // This condition triggers W442c
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end

endmodule
