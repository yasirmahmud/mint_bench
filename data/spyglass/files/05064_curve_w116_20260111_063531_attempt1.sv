module curve_w116_20260111_063531_attempt1 (
    input [10:0] TC,
    output [9:0] result
);

    assign result = TC[10] & (~TC[9:0]);

endmodule
