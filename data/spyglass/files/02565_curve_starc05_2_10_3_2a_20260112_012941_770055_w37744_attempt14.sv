module curve_starc05_2_10_3_2a_20260112_012941_770055_w37744_attempt14 (
    input enable_cond,
    input [5:0] address_register,
    output reg active_status
);

    // STARC05-2.10.3.2a: Operand bit-width mismatch for operator '&&'
    // 'enable_cond' is 1-bit, 'address_register' is 6-bit.
    // This non-blocking assignment within an always block causes the violation.
    always @(*) begin
        active_status <= enable_cond && address_register;
    end

endmodule
