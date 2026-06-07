module curve_starc05_2_3_3_1_20260111_074649_attempt3 (
    input wire clk_a,
    input wire clk_b,
    input wire data_in_a,
    input wire data_in_b,
    output reg q_out_a,
    output reg q_out_b
);

    // STARC05-2.3.3.1 violation: Edges of multiple clocks used in the same always block.
    // This always block's sensitivity list includes edges from two distinct clock signals (clk_a and clk_b).
    // This directly violates the rule by mixing different clock domains within a single sequential block.
    always @(posedge clk_a or posedge clk_b) begin
        // The logic inside is minimal, focusing solely on demonstrating the sensitivity list violation.
        q_out_a <= data_in_a;
        q_out_b <= data_in_b;
    end

endmodule
