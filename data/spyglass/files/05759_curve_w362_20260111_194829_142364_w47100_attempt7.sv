module curve_w362_20260111_194829_142364_w47100_attempt7 (
    input [15:0] val_a,
    input [31:0] threshold_b,
    output is_less
);

    assign is_less = (val_a < threshold_b); // W362 violation expected: width mismatch for operator (<)

endmodule
