module curve_wrn_71_20260112_005236_645918_w37744_attempt16 (
    input [7:0] in_data,
    output [10:0] out_a,
    output [10:0] out_b
);

    // WRN_71 Violation 1:
    // The expression (7 / R_DENOM) involves a real number (R_DENOM),
    // making the result a real number (3.5). Verilog will implicitly
    // truncate it to 3 for replication ({3{1'b0}}), but SpyGlass triggers WRN_71
    // because the *type* of the multiplier expression is 'real', not 'integer'.
    localparam real R_DENOM = 2.0;
    assign out_a = {{ (7 / R_DENOM) {1'b0} }, in_data};

    // WRN_71 Violation 2:
    // The repetition multiplier '3.1' is an explicit real number literal
    // with a non-zero fractional part. Verilog will implicitly truncate it
    // to 3 for replication ({3{1'b0}}), but SpyGlass triggers WRN_71 because the
    // multiplier is not an integer type.
    assign out_b = {{ 3.1 {1'b0} }, in_data};

endmodule
