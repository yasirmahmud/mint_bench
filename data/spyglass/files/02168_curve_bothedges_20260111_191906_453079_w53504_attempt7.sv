module curve_bothedges_20260111_191906_453079_w53504_attempt7 (
    input clk,
    output reg out_toggle
);

    // SpyGlass bothedges violation will occur here
    // Both posedge and negedge of the same signal 'clk' are used in the event control list.
    always @(posedge clk or negedge clk) begin
        out_toggle <= !out_toggle; // Toggle output on both clock edges
    end

endmodule
