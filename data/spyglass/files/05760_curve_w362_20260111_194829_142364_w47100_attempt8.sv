module curve_w362_20260111_194829_142364_w47100_attempt8 (
    input [7:0] data_in_8bit,
    input [31:0] max_val_32bit,
    output is_greater
);

    assign is_greater = (data_in_8bit > max_val_32bit); // W362 violation expected: width mismatch for operator (>)

endmodule
