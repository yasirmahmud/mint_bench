module curve_starc05_2_3_3_1_20260111_074649_attempt6 (
    input wire clk_a,
    input wire clk_b, // Treated as a second clock, negative edge sensitive here
    input wire data_in,
    output reg q_out
);

    // STARC05-2.3.3.1 violation: Edges of multiple clocks (clk_a, clk_b) are used in the same always block's sensitivity list.
    // clk_a is posedge sensitive, and clk_b is negedge sensitive. This explicit use of two distinct clock edges within
    // a single always block directly triggers the STARC05-2.3.3.1 rule as per its description.
    always @(posedge clk_a or negedge clk_b) begin
        q_out <= data_in;
    end

endmodule
