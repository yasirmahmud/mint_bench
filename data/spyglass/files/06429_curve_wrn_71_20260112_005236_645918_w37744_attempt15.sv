module curve_wrn_71_20260112_005236_645918_w37744_attempt15 (
    input [7:0] in_data,
    output [10:0] out_a,
    output [10:0] out_b
);

    // WRN_71 Violation 1:
    // The expression (A_REAL + A_INT) results in a real number (3.0),
    // even though its fractional part is zero. Verilog will implicitly
    // truncate it to 3 for replication, but SpyGlass triggers WRN_71
    // because the *type* of the multiplier expression is 'real', not 'integer'.
    localparam real A_REAL = 2.0;
    localparam int A_INT = 1;
    assign out_a = {{ (A_REAL + A_INT) {1'b0} }, in_data};

    // WRN_71 Violation 2:
    // The localparam B_REPEAT_VAL is explicitly declared as 'real' (3.0).
    // Even though its value is an integer, its type is 'real'.
    // Using a 'real' type as the repetition multiplier triggers WRN_71.
    localparam real B_REPEAT_VAL = 3.0;
    assign out_b = {{ B_REPEAT_VAL {1'b0} }, in_data};

endmodule
