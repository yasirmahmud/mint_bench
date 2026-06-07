module curve_wrn_71_20260112_005236_645918_w37744_attempt14 (
    input [7:0] in_data,
    output [10:0] out_a,
    output [10:0] out_b
);

    // WRN_71 Violation 1:
    // The repetition multiplier (10.0 / 3.0) evaluates to a real number (approx 3.33...).
    // Even though Verilog will implicitly truncate this to an integer (3) for replication,
    // SpyGlass triggers WRN_71 because the *type* of the expression is 'real', not 'integer'.
    assign out_a = {{(10.0 / 3.0){1'b0}}, in_data};

    // WRN_71 Violation 2:
    // The expression (FACTOR_R * FACTOR_I) involves a 'real' operand (FACTOR_R),
    // causing the entire expression to resolve to a 'real' type (1.5 * 2 = 3.0).
    // Although the value '3.0' is equivalent to an integer (3), and Verilog will use 3 for replication,
    // SpyGlass triggers WRN_71 because the *type* of the multiplier expression is 'real', not 'integer'.
    localparam real FACTOR_R = 1.5;
    localparam int FACTOR_I = 2;
    assign out_b = {{(FACTOR_R * FACTOR_I){1'b0}}, in_data};

endmodule
