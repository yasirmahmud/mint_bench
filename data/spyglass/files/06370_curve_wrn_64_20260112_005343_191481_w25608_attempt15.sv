module curve_wrn_64_20260112_005343_191481_w25608_attempt15 (
    input [7:0] data_in,
    output [3:0] out_msb_oob,
    output [5:0] out_lsb_oob
);

    // WRN_64 occurrence 1:
    // Part-select [9:6] is out of range for 'data_in[7:0]'.
    // The MSB index '9' is greater than the declared MSB '7' of 'data_in'.
    assign out_msb_oob = data_in[9:6];

    // WRN_64 occurrence 2:
    // Part-select [2:-3] is out of range for 'data_in[7:0]'.
    // The LSB index '-3' is less than the declared LSB '0' of 'data_in'.
    assign out_lsb_oob = data_in[2:-3];

endmodule
