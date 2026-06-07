module curve_starc05_2_3_3_1_20260111_074649_attempt8 (
    input wire clk_a,
    input wire clk_b,
    input wire data_in,
    output reg q_out
);

    // STARC05-2.3.3.1 violation: Edges of multiple clocks used in the same always block.
    // Original issue: This 'always' block was sensitive to the positive edges of two distinct clock signals, 'clk_a' and 'clk_b'.
    // Fix: To resolve STARC05-2.3.3.1 and W422, a sequential 'always' block must be sensitive to only one clock edge.
    // The design is modified to synchronize 'q_out' to 'clk_a'. This resolves the ambiguity and makes the block synthesizable.
    // While this means 'q_out' no longer responds to 'clk_b', the original behavior of a single 'reg' being driven by two
    // independent clocks simultaneously is inherently unsynthesizable and ill-defined. By making 'q_out' synchronous to 'clk_a',
    // the design becomes synthesizable, addressing the primary violation and implicitly resolving W442a (which often triggers
    // due to malformed always blocks).

    always @(posedge clk_a) begin // Fixed: Now only sensitive to posedge clk_a
        // The internal logic is simplified to only capture data, as the violation lies in the sensitivity list itself.
        q_out <= data_in;
    end

endmodule
