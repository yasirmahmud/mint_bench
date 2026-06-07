module curve_wrn_64_20260111_181106_154939_w53504_attempt9 (
    input [3:0] data_in,
    output [2:0] out1,
    output [2:0] out2,
    output [3:0] valid_out
);

    // To avoid W240 (unused input) and ensure data_in is properly consumed.
    assign valid_out = data_in;

    // WRN_64 occurrence 1:
    // Part-select [4:2] is out of range for 'data_in' which is [3:0].
    // The MSB index '4' is greater than the declared MSB '3' of 'data_in'.
    assign out1 = data_in[4:2];

    // WRN_64 occurrence 2:
    // Part-select [1:-1] is out of range for 'data_in' which is [3:0].
    // The LSB index '-1' is less than the declared LSB '0' of 'data_in'.
    assign out2 = data_in[1:-1];

endmodule
