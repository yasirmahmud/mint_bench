module curve_starc05_2_3_3_1_20260111_074649_attempt5 (
    input wire clk_a,
    input wire clk_b,
    input wire data_in_a,
    input wire data_in_b,
    output reg q_out_a,
    output reg q_out_b
);

    // STARC05-2.3.3.1 violation: Edges of multiple clocks used in the same always block.
    // This always block's sensitivity list directly includes edge events from two distinct clock signals, clk_a and clk_b.
    // This construct unambiguously triggers the STARC05-2.3.3.1 rule, as it uses edges of multiple identified "clocks" in a single sequential block.
    always @(posedge clk_a or posedge clk_b) begin
        q_out_a <= data_in_a;
        q_out_b <= data_in_b;
    end

endmodule
