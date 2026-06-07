module curve_w362_20260111_194829_142364_w47100_attempt10 (
    input [7:0] data_in,
    input [31:0] r_max,
    output is_over_max
);

    // W362 violation expected: For operator (>), left expression width 8 should match right expression width 32
    assign is_over_max = (data_in > r_max);

endmodule
