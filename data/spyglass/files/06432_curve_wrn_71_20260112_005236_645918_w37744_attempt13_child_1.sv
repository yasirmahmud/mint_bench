module curve_wrn_71_20260112_005236_645918_w37744_attempt13 (
    input [7:0] in_data,
    output [10:0] out_a,
    output [10:0] out_b
);

    // WRN_71 Violation 1:
    // The repetition multiplier 'REPEAT_FACTOR_A' is declared as a 'real' type.
    // Even though its value (3.0) is an integer, SpyGlass reports WRN_71 because
    // the *type* of the multiplier expression is not integer.
    // FIX: Changed localparam type to 'int' to make the multiplier an integer.
    localparam int REPEAT_FACTOR_A = 3; // Changed from real 3.0 to int 3
    assign out_a = { {REPEAT_FACTOR_A}{1'b0}, in_data }; // Fixed concatenation syntax

    // WRN_71 Violation 2:
    // The expression '(NUMERATOR / DENOMINATOR)' involves a 'real' operand (DENOMINATOR),
    // making the entire expression resolve to a 'real' type (7 / 2.0 = 3.5).
    // Although Verilog will implicitly truncate 3.5 to 3 for the replication,
    // SpyGlass flags WRN_71 because the *type* of the multiplier expression is not integer.
    // FIX: Changed 'DENOMINATOR' to 'int' so that the division results in an integer (7 / 2 = 3),
    // preserving the functional behavior of implicit truncation.
    localparam int NUMERATOR = 7;
    localparam int DENOMINATOR = 2; // Changed from real 2.0 to int 2
    assign out_b = { {(NUMERATOR / DENOMINATOR){1'b0}}, in_data }; // Fixed concatenation syntax

endmodule
