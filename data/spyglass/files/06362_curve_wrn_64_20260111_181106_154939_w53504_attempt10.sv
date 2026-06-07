module curve_wrn_64_20260111_181106_154939_w53504_attempt10 (
    input [3:0] data_in,
    output [2:0] out1,
    output [2:0] out2,
    output [3:0] valid_out
);

    // Input vector properties
    localparam DATA_MSB = 3;
    localparam DATA_LSB = 0;
    localparam OUT_WIDTH = 3;

    // Parameters to define out-of-range part-selects, ensuring output width match.
    // Occurrence 1: Highest bit of part-select is out of range (MSB too high).
    // data_in is [3:0]. For a 3-bit output (OUT_WIDTH = 3), if LSB is 2, then MSB is 2 + 3 - 1 = 4.
    // So, part-select [4:2] includes bit 4, which is out of range.
    localparam OOR1_HIGH_IDX = DATA_MSB + 1; // 4
    localparam OOR1_LOW_IDX  = OOR1_HIGH_IDX - OUT_WIDTH + 1; // 4 - 3 + 1 = 2

    // Occurrence 2: Lowest bit of part-select is out of range (LSB too low/negative).
    // data_in is [3:0]. For a 3-bit output (OUT_WIDTH = 3), if MSB is 1, then LSB is 1 - 3 + 1 = -1.
    // So, part-select [1:-1] includes bit -1, which is out of range.
    localparam OOR2_HIGH_IDX = DATA_LSB + OUT_WIDTH - 2; // 0 + 3 - 2 = 1
    localparam OOR2_LOW_IDX  = DATA_LSB - 1; // -1

    // Consume data_in to avoid W240 (unused input) if not directly used elsewhere.
    assign valid_out = data_in;

    // WRN_64 occurrence 1: Part-select [4:2] is out of range for 'data_in[3:0]'.
    // The MSB index '4' is greater than the declared MSB '3' of 'data_in'.
    assign out1 = data_in[OOR1_HIGH_IDX:OOR1_LOW_IDX];

    // WRN_64 occurrence 2: Part-select [1:-1] is out of range for 'data_in[3:0]'.
    // The LSB index '-1' is less than the declared LSB '0' of 'data_in'.
    assign out2 = data_in[OOR2_HIGH_IDX:OOR2_LOW_IDX];

endmodule
