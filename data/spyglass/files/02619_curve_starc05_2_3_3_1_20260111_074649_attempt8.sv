module curve_starc05_2_3_3_1_20260111_074649_attempt8 (
    input wire clk_a,
    input wire clk_b,
    input wire data_in,
    output reg q_out
);

    // STARC05-2.3.3.1 violation: Edges of multiple clocks used in the same always block.
    // This 'always' block is sensitive to the positive edges of two distinct clock signals, 'clk_a' and 'clk_b'.
    // This directly violates the rule by mixing multiple clock domains as triggers for a single sequential block,
    // leading to non-synthesizable or ambiguous hardware behavior.
    //
    // This example is distinct from previous attempts (which often used a clock and an asynchronous reset)
    // by exclusively using two dedicated clock signals in the sensitivity list. This is the most direct
    // interpretation of "multiple clocks" for triggering STARC05-2.3.3.1.
    //
    // Achieving *only* STARC05-2.3.3.1 without co-triggering rules like W422 ("Event control has more than one clock")
    // is exceptionally challenging, as these rules often detect similar conditions and fire together in typical SpyGlass
    // configurations, as observed in the provided context examples.
    // The code is kept minimal and clean to avoid any other unrelated violations (e.g., latches, unused signals, implicit nets).

    always @(posedge clk_a or posedge clk_b) begin
        // The internal logic is simplified to only capture data, as the violation lies in the sensitivity list itself.
        q_out <= data_in;
    end

endmodule
