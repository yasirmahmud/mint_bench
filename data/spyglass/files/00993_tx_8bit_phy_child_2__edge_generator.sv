// Dummy module definition for edge_generator (ErrorAnalyzeBBox fix)
// This module detects rising and falling edges of an input signal.
module edge_generator #(
    parameter MODE = "BEST" // FAST NORMAL BEST - parameter is not used in this dummy implementation
)(
    input clk,
    input rst_n,
    input in,
    output raising,
    output falling
);
    reg in_d0, in_d1;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            in_d0 <= 1'b0;
            in_d1 <= 1'b0;
        end else begin
            in_d0 <= in;
            in_d1 <= in_d0;
        end
    end
    assign raising = in_d0 & ~in_d1;
    assign falling = ~in_d0 & in_d1;
endmodule
