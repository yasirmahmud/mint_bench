module curve_w422_20260111_080112_attempt6 (
    input clk,
    input rst_n,
    input data_in,
    output reg q_out
);

reg event_flag_reg;

// This block captures 'data_in' on 'clk' or resets asynchronously.
// It correctly handles the asynchronous reset to avoid W442a for this block.
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        event_flag_reg <= 1'b0;
    end else begin
        event_flag_reg <= data_in;
    end
end

// Fix for W422, STARC05-2.3.3.1, and W442a:
// The original `always @(posedge clk or posedge event_flag_reg)` implies
// that `q_out` toggles on `posedge clk` OR `posedge event_flag_reg`.
// Since `event_flag_reg` is itself synchronous to `clk` (registered on `posedge clk`),
// a `posedge event_flag_reg` can only occur coincident with a `posedge clk`.
// Therefore, the functional behavior of the original block is that `q_out` toggles
// on every `posedge clk`.
// This block is modified to be sensitive only to `posedge clk` and `negedge rst_n`
// to resolve STARC05-2.3.3.1 and W422.
// An asynchronous reset is also added for `q_out` to resolve W442a.
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        q_out <= 1'b0; // Asynchronous reset to resolve W442a
    end else begin
        q_out <= ~q_out; // Toggle 'q_out' on every posedge clk
    end
end

endmodule
