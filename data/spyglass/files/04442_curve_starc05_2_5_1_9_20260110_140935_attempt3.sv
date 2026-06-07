module curve_starc05_2_5_1_9_20260110_140935_attempt3 (
    input wire sel_a_i,
    input wire data_in_a_i,
    input wire sel_b_i,
    input wire data_in_b_i,
    output tri tri_out_a_o,
    output tri tri_out_b_o,
    output reg result_a_o,
    output reg result_b_o
);

    // Create the first 1-bit tri-state output signal.
    // Its value can be high-impedance (z) based on sel_a_i.
    assign tri_out_a_o = sel_a_i ? 1'bz : data_in_a_i;

    // Use the first 1-bit tri-state output in a casex statement.
    // This will trigger the first STARC05-2.5.1.9 violation.
    always @(*) begin
        result_a_o = 1'bx; // Default assignment to prevent latches
        casex (tri_out_a_o) // Violation 1: tri_out_a_o used in casex selection
            1'b0: result_a_o = 1'b0;
            1'b1: result_a_o = 1'b1;
            // casex handles 'x' and 'z' patterns, covering all possibilities
        endcase
    end

    // Create the second 1-bit tri-state output signal.
    // Its value can be high-impedance (z) based on sel_b_i (with inverted logic for distinction).
    assign tri_out_b_o = sel_b_i ? data_in_b_i : 1'bz;

    // Use the second 1-bit tri-state output in another casex statement.
    // This will trigger the second STARC05-2.5.1.9 violation,
    // addressing the "Total occurrences (from summary): 2" requirement.
    always @(*) begin
        result_b_o = 1'bx; // Default assignment to prevent latches
        casex (tri_out_b_o) // Violation 2: tri_out_b_o used in casex selection
            1'b0: result_b_o = 1'b1; // Different assignment values for distinction
            1'b1: result_b_o = 1'b0;
            // casex handles 'x' and 'z' patterns, covering all possibilities
        endcase
    end

endmodule
