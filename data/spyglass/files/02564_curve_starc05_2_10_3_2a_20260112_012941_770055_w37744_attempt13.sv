module curve_starc05_2_10_3_2a_20260112_012941_770055_w37744_attempt13 (
    input control_signal,
    input [4:0] address_bus,
    output access_valid_flag
);

    // STARC05-2.10.3.2a: Operand bit-width mismatch for operator '&&'
    // 'control_signal' is 1-bit, 'address_bus' is 5-bit.
    // This assignment causes the violation.
    assign access_valid_flag = control_signal && address_bus;

endmodule
