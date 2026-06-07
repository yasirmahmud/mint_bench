module curve_wrn_27_20260112_005335_137375_w6680_attempt14 (
    input [1:0] in_data,
    output      out1,
    output      out2,
    output      dummy_read_out
);

    wire [1:0] internal_vec;

    // Connect input to internal wire to ensure 'internal_vec' is driven.
    assign internal_vec = in_data;

    // WRN_27 violation 1: Bit-select -1 is out-of-range for a [1:0] vector.
    // Verilog bit-selects must be non-negative. This triggers WRN_27.
    assign out1 = internal_vec[-1];

    // WRN_27 violation 2: Bit-select -2 is out-of-range for a [1:0] vector.
    // Verilog bit-selects must be non-negative. This triggers WRN_27.
    assign out2 = internal_vec[-2];

    // To prevent W528 (unused signal) for internal_vec[1:0],
    // assign one of its valid bits to an output.
    assign dummy_read_out = internal_vec[0];

endmodule
