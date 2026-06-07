module curve_bothedges_20260111_224245_803937_w32456_attempt11 (
    input clk,
    output reg [1:0] counter_out
);

    // SpyGlass bothedges violation will occur here.
    // Both posedge and negedge of the same signal 'clk' are used in the event control list.
    always @(posedge clk or negedge clk) begin
        counter_out <= counter_out + 1'b1; // Increment a 2-bit counter on both clock edges
    end

endmodule
