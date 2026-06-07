module curve_wrn_64_20260111_181106_154939_w53504_attempt7 (
    input wire [3:0] data_in,
    output wire [1:0] data_out
);

    // WRN_64: Part-select is out-of-range
    // data_in is a 4-bit vector (indices 3 down to 0).
    // The part-select data_in[5:4] attempts to access bits at index 5 and 4,
    // both of which are outside the declared range of data_in.
    // This single assignment is expected to trigger WRN_64 with two occurrences
    // due to both the upper bound (5) and lower bound (4) being out of range.
    assign data_out = data_in[5:4];

endmodule
