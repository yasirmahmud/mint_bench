module curve_wrn_27_20260112_005335_137375_w6680_attempt13 (
    input [1:0] in_data,
    output      out1,
    output      out2
);

    // Declare an internal wire with a range of [1:0]
    wire [1:0] internal_vector;

    // Connect input to internal wire to ensure 'internal_vector' is driven and used.
    assign internal_vector = in_data;

    // WRN_27 violation 1: Bit-select 2 is out-of-range for a [1:0] vector.
    // The highest valid index for 'internal_vector' is 1.
    assign out1 = internal_vector[2];

    // WRN_27 violation 2: Bit-select -1 is out-of-range for a [1:0] vector.
    // The lowest valid index for 'internal_vector' is 0. Negative indices are always out of range.
    assign out2 = internal_vector[-1];

endmodule
