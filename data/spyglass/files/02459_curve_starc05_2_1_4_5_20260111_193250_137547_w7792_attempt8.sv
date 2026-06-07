module curve_starc05_2_1_4_5_20260111_193250_137547_w7792_attempt8 (
    input [2:0] ctrl_a,
    input [2:0] ctrl_b,
    output logic output_flag
);

    // STARC05-2.1.4.5: Using logical AND (&&) with multi-bit operands 'ctrl_a' and 'ctrl_b'
    assign output_flag = ctrl_a && ctrl_b;

endmodule
