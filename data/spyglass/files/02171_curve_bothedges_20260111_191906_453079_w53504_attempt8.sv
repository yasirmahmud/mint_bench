module curve_bothedges_20260111_191906_453079_w53504_attempt8 (
    input clk,
    input in_data,
    output reg out_data
);

    // SpyGlass bothedges violation will occur here
    // Both posedge and negedge of the same signal 'clk' are used in the event control list.
    always @(posedge clk or negedge clk) begin
        out_data <= in_data; // Simple data transfer creates a dual-edge flip-flop
    end

endmodule
