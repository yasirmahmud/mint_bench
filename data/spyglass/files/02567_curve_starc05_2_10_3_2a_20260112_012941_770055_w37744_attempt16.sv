module curve_starc05_2_10_3_2a_20260112_012941_770055_w37744_attempt16 (
    input wr_en_in,          // 1-bit control signal
    input [4:0] rd_addr_in,  // 5-bit address signal
    output reg logic_out    // Output to store the logical result
);

    // STARC05-2.10.3.2a: Operand bit-width mismatch for operator '&&'
    // 'wr_en_in' is 1-bit, 'rd_addr_in' is 5-bit.
    // The logical AND operator '&&' is used with operands of mismatched widths.
    // This directly triggers the target rule.
    always @(*) begin
        logic_out = wr_en_in && rd_addr_in;
    end

endmodule
