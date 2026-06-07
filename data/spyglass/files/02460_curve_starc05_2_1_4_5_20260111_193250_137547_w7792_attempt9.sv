module curve_starc05_2_1_4_5_20260111_193250_137547_w7792_attempt9 (
    input [4:0] operand_a,
    input [4:0] operand_b,
    output reg final_result
);

    // STARC05-2.1.4.5: Using logical AND (&&) with multi-bit operands 'operand_a' and 'operand_b'
    always @* begin
        final_result = operand_a && operand_b;
    end

endmodule
