module curve_starc05_2_1_4_5_20260111_193250_137547_w7792_attempt6 (
    input [1:0] data_a,
    input [2:0] data_b,
    output result_out
);

    // STARC05-2.1.4.5: Using logical AND (&&) with multi-bit operands
    assign result_out = data_a && data_b;

endmodule
