module curve_w116_20260111_063531_attempt4 (
    input [15:0] data_in,
    output wire flag_out
);

    // W116: For operator (&), left expression width (1 bit) should match right expression width (15 bits).
    // Specifically, data_in[15] (1 bit) is ANDed with (~data_in[14:0]) (15 bits).
    assign flag_out = data_in[15] & (~data_in[14:0]);

endmodule
