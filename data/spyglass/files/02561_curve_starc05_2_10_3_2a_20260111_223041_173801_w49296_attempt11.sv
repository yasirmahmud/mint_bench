module curve_starc05_2_10_3_2a_20260111_223041_173801_w49296_attempt11 (
    input wire ctrl_signal,
    input wire [3:0] config_value,
    output wire output_flag
);

    // STARC05-2.10.3.2a: Operand bit-width mismatch for operator '&&'
    // 'ctrl_signal' is 1-bit, 'config_value' is 4-bit.
    assign output_flag = ctrl_signal && config_value;

endmodule
