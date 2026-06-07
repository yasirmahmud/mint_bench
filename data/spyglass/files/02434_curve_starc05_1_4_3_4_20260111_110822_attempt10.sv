module curve_starc05_1_4_3_4_20260111_110822_attempt10 (
    input clk_primary,        // Main system clock
    input clk_to_violate,     // This signal will be classified as a clock
    output reg q_clocked_by_violate_clk,
    output reg q_data_from_violate_clk
);

    // Block 1: Establish 'clk_to_violate' as a clock signal.
    // SpyGlass will identify 'clk_to_violate' as a clock due to its use here.
    always @(posedge clk_to_violate) begin
        q_clocked_by_violate_clk <= 1'b1; // Assign a constant to keep it simple
    end

    // Block 2: Use 'clk_to_violate' (which is now classified as a clock) as a non-clock signal.
    // Here, 'clk_to_violate' is used as a data input to a flip-flop clocked by 'clk_primary'.
    // This usage as a data signal will trigger the STARC05-1.4.3.4 violation.
    always @(posedge clk_primary) begin
        q_data_from_violate_clk <= clk_to_violate; // 'clk_to_violate' is used as data input.
    end

endmodule
