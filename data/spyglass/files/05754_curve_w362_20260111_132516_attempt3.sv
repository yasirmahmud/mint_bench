module curve_w362_20260111_132516_attempt3 (
    input [7:0] data_value,
    input [15:0] compare_limit,
    output wire greater_flag
);

    // W362: For operator (>), left expression: "data_value" width 8 should match right expression: "compare_limit" width 16
    assign greater_flag = (data_value > compare_limit);

endmodule
