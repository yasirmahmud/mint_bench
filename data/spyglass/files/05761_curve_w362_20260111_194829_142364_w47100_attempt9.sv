module curve_w362_20260111_194829_142364_w47100_attempt9 (
    input [7:0] data_val,
    input [31:0] limit_val,
    output is_under_limit
);

    // W362 violation expected: Width mismatch for operator (<)
    assign is_under_limit = (data_val < limit_val);

endmodule
