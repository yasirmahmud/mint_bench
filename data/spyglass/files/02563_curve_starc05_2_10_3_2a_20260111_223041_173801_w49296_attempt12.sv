module curve_starc05_2_10_3_2a_20260111_223041_173801_w49296_attempt12 (
    input wire  wr_en_in,       // 1-bit signal
    input wire  [4:0] rd_addr_in, // 5-bit signal
    output wire data_valid_flag
);

    // STARC05-2.10.3.2a: Operand bit-width mismatch for operator '&&'
    // 'wr_en_in' is 1-bit, 'rd_addr_in' is 5-bit, directly matching the rule description.
    // This assignment causes a width mismatch for the '&&' operator.

    assign data_valid_flag = wr_en_in && rd_addr_in;

endmodule
