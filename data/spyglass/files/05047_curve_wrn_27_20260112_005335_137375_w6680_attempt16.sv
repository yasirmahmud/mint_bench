module curve_wrn_27_20260112_005335_137375_w6680_attempt16 (
    output wire out_bit_a,
    output wire out_bit_b
);

    // WRN_27 violation 1: Bit-select 4 is out-of-range for a 4-bit constant [3:0].
    // The constant 4'hA (binary 1010) has bits indexed 3, 2, 1, 0. Index 4 is out of range.
    // This direct assignment from a constant value to an output aims to trigger
    // only WRN_27, potentially avoiding SYNTH_5255 and W528 by leveraging constant folding.
    assign out_bit_a = 4'hA[4];

    // WRN_27 violation 2: Bit-select 5 is out-of-range for a 4-bit constant [3:0].
    // Index 5 is also out of range for the 4-bit constant.
    assign out_bit_b = 4'hA[5];

endmodule
