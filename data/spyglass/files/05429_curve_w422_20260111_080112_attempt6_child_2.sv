module curve_w422_20260111_080112_attempt6 (
    input clk,
    input rst_n,
    input data_in,
    output reg q_out
);

// Fix for W422, STARC05-2.3.3.1, and W442a:
// The original `always @(posedge clk or posedge event_flag_reg)` implied
// that `q_out` toggled on `posedge clk` OR `posedge event_flag_reg`.
// As `event_flag_reg` itself was synchronous to `clk`, a `posedge event_flag_reg`
// would occur coincident with a `posedge clk`.
// Therefore, the functional behavior of the original design was that `q_out` toggled
// on every `posedge clk`. This is preserved.
// This block is sensitive only to `posedge clk` and `negedge rst_n`
// to resolve STARC05-2.3.3.1 and W422.
// An asynchronous reset is also added for `q_out` to resolve W442a.
// The 'event_flag_reg' and its driving logic have been removed as they are no longer
// functionally used to derive 'q_out' based on the specified behavior,
// resolving the W528 violation (variable set but not read).
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        q_out <= 1'b0; // Asynchronous reset to resolve W442a
    end else begin
        q_out <= ~q_out; // Toggle 'q_out' on every posedge clk
    end
end

endmodule
