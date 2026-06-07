module curve_bothedges_20260111_224245_803937_w32456_attempt12 (
    input clk,
    input reset_n,
    output reg data_out
);

    // SpyGlass bothedges violation will occur here.
    // Both posedge and negedge of the same signal 'clk' are used in the event control list.
    always @(posedge clk or negedge clk or negedge reset_n) begin
        if (!reset_n) begin
            data_out <= 1'b0; // Asynchronous reset
        end else begin
            data_out <= ~data_out; // Toggle on both clock edges when not in reset
        end
    end

endmodule
