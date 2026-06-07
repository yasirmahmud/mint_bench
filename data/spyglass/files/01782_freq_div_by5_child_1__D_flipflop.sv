module D_flipflop(
    input clk, reset,
    input d,
    output reg q_out
    );

    // This DFF is positive-edge triggered with respect to its own 'clk' input.
    // In the parent module, this 'clk' input is connected to `~clk` (inverted top-level clock).
    // Therefore, it acts as a negative-edge triggered DFF with respect to the top-level clock.
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q_out <= 1'b0;
        end else begin
            q_out <= d;
        end
    end

endmodule
