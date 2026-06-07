module curve_starc05_2_10_3_2a_20260112_012941_770055_w37744_attempt15 (
    input control_signal,
    input [4:0] multi_bit_data,
    output active_flag
);

    // Declare output as wire (default for 'output' in Verilog-2001)
    wire active_flag;

    // STARC05-2.10.3.2a: Operand bit-width mismatch for operator '&&'
    // 'control_signal' is 1-bit, 'multi_bit_data' is 5-bit.
    // The logical AND operator '&&' is used with operands of mismatched widths.
    // The expression (control_signal && multi_bit_data) serves as the condition
    // in a ternary operator, which strictly expects a 1-bit boolean result.
    // This construction is intended to isolate STARC05-2.10.3.2a by clearly defining
    // a logical context, hoping to minimize or eliminate related violations like
    // STARC05-2.1.4.5 ('Use bit-wise operator instead of logical operator "&&"').
    assign active_flag = (control_signal && multi_bit_data) ? 1'b1 : 1'b0;

endmodule
