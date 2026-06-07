module curve_bothedges_20260111_191906_453079_w53504_attempt10 (
    input clk,
    input data_in,
    output reg data_out
);

    // SpyGlass bothedges violation will occur here.
    // Both posedge and negedge of the same signal 'clk' are used in the event control list.
    always @(posedge clk or negedge clk) begin
        data_out <= data_in; // Simple dual-edge data pass-through
    end

endmodule
