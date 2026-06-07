module curve_w486_20260111_225051_676022_w49296_attempt12 (
    input wire [10:0] data_in_a,
    input wire [10:0] data_in_b,
    output wire [7:0] result_out
);

    // W486 violation: RHS width (12 bits from data_in_a + data_in_b) with shift
    // is more than LHS width (8 bits for result_out). Max sum 2047+2047=4094,
    // requiring 12 bits. The shift does not reduce the conceptual width for this rule.
    assign result_out = (data_in_a + data_in_b) >> 1;

endmodule
