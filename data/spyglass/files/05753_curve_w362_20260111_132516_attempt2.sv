module curve_w362_20260111_132516_attempt2 (
    input [15:0] value_a,
    input [3:0] limit_b,
    output reg output_cond
);

    // W362: For operator (<=), left expression: "value_a" width 16 should match right expression: "limit_b" width 4
    always @(*) begin
        output_cond = (value_a <= limit_b);
    end

endmodule
