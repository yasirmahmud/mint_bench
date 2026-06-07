module curve_wrn_27_20260112_005335_137375_w6680_attempt16 (
    output wire out_bit_a,
    output wire out_bit_b
);

    // WRN_27 violation 1: Bit-select 4 is out-of-range for a 4-bit constant [3:0].
    // The constant 4'hA (binary 1010) has bits indexed 3, 2, 1, 0. Index 4 is out of range.
    // In Verilog, accessing an out-of-range bit evaluates to 'X'. To resolve the STX_VE_481
    // syntax error and WRN_27 violation while preserving this functional behavior, we explicitly assign 'X'.
    assign out_bit_a = 1'bx;

    // WRN_27 violation 2: Bit-select 5 is out-of-range for a 4-bit constant [3:0].
    // Index 5 is also out of range for the 4-bit constant. As above, explicitly assign 'X'.
    assign out_bit_b = 1'bx;

endmodule
