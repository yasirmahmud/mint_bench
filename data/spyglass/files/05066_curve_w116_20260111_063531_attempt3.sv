module curve_w116_20260111_063531_attempt3 (
    input [7:0] my_data,
    output wire result
);

    // W116: Width mismatch for operator (&). Left operand (my_data[7]) is 1 bit,
    // while right operand (~my_data[6:0]) is 7 bits.
    assign result = my_data[7] & (~my_data[6:0]);

endmodule
