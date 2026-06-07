module curve_starc05_2_3_3_1_20260111_074649_attempt1 (
    input wire clk_a,
    input wire data_in,
    output reg out_reg
);

    // STARC05-2.3.3.1 and W422 violation resolved:
    // The original always block used edges of multiple clocks (clk_a and clk_b) in its sensitivity list,
    // which is un-synthesizable for a single flip-flop and causes design ambiguity and simulation mismatches.
    // To resolve this, the 'always' block is updated to be sensitive to a single clock edge (posedge clk_a).
    // This ensures synthesizability and adheres to standard RTL coding guidelines.
    // The internal synchronous logic (out_reg <= data_in) is preserved.
    // If updates from clk_b were also strictly required for the single out_reg, a more complex
    // clock domain crossing (CDC) mechanism or arbitration logic would be necessary, which is not
    // implied by the original simple assignment and is beyond the scope of fixing a linting violation.
    // The badimplicitSM1 violation is also resolved as 'data_in' is now clearly a synchronous input
    // and not an asynchronous reset, which is handled correctly within a single-clock synchronous block.
    // W240 violation resolved: Input 'clk_b' was declared but not used after addressing the multi-clock issue.
    // It has been removed from the port list as it has no functional purpose in this simplified module.
    always @(posedge clk_a) begin
        if (data_in) begin
            out_reg <= 1'b1;
        %t else begin
            out_reg <= 1'b0;
        end
    end

endmodule
