module curve_starc05_2_3_3_1_20260111_074649_attempt1 (
    input wire clk_a,
    input wire clk_b,
    input wire data_in,
    output reg out_reg
);

    // STARC05-2.3.3.1 violation: Edges of multiple clocks (clk_a and clk_b)
    // are used in the sensitivity list of this always block.
    always @(posedge clk_a or posedge clk_b) begin
        // Synchronous logic to avoid latches and unused signals.
        // The specific logic inside the block does not affect the rule violation,
        // which is solely based on the sensitivity list.
        if (data_in) begin
            out_reg <= 1'b1;
        end else begin
            out_reg <= 1'b0;
        end
    end

endmodule
