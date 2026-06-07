module curve_wrn_64_attempt11_dut (
    input [10:0] data_in,
    output [2:0] out_high_oob,
    output [2:0] out_low_oob
);

    // WRN_64 occurrence 1:
    // Part-select [12:10] is out of range for 'data_in' which is [10:0].
    // The MSB index '12' is greater than the declared MSB '10' of 'data_in'.
    assign out_high_oob = data_in[12:10];

    // WRN_64 occurrence 2:
    // Part-select [1:-1] is out of range for 'data_in' which is [10:0].
    // The LSB index '-1' is less than the declared LSB '0' of 'data_in'.
    assign out_low_oob = data_in[1:-1];

endmodule
