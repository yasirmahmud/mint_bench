module curve_wrn_64_20260112_005343_191481_w25608_attempt13 (
    input [4:0] data_in,
    output [3:0] out_msb_oob,
    output [4:0] out_lsb_oob
);

    // WRN_64 occurrence 1:
    // Part-select [5:2] is out of range for 'data_in[4:0]'.
    // The MSB index '5' is greater than the declared MSB '4' of 'data_in'.
    assign out_msb_oob = data_in[5:2];

    // WRN_64 occurrence 2:
    // Part-select [3:-1] is out of range for 'data_in[4:0]'.
    // The LSB index '-1' is less than the declared LSB '0' of 'data_in'.
    assign out_lsb_oob = data_in[3:-1];

endmodule
