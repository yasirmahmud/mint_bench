module curve_w116_20260111_063531_attempt2 (
    input [9:0] in_data,
    output wire result
);

    // W116: Width mismatch for operator. Left (in_data[9]) is 1 bit,
    // while right (~in_data[8:0]) is 9 bits.
    assign result = in_data[9] | (~in_data[8:0]);

endmodule
