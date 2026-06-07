module curve_starc05_2_5_1_9_20260110_140935_attempt5 (
    input wire i_sel,
    input wire [1:0] i_data_in,
    output tri [1:0] o_tri_bus,
    output reg [1:0] o_data_out
);

    // This assigns the 2-bit tri-state output 'o_tri_bus'.
    // When 'i_sel' is 0, 'o_tri_bus' becomes 2'bzz (high-impedance on both bits).
    // When 'i_sel' is 1, 'o_tri_bus' takes the value of 'i_data_in'.
    assign o_tri_bus = i_sel ? i_data_in : 2'bzz;

    always @(*) begin
        // Default assignment for 'o_data_out' to prevent latches and 'NoAssignX-ML' violations.
        o_data_out = 2'b00;

        // STARC05-2.5.1.9 violation:
        // The 2-bit tri-state output 'o_tri_bus' is used in the selection expression
        // of a casez statement. The rule specifies "bits(s)", implying that a multi-bit
        // tri-state signal can trigger multiple occurrences if each bit is considered.
        // This setup aims to trigger 2 warnings, one for each bit of 'o_tri_bus',
        // matching the target "Total occurrences: 2".
        casez (o_tri_bus)
            2'b00: o_data_out = 2'b00;
            2'b01: o_data_out = 2'b01;
            2'b10: o_data_out = 2'b10;
            2'b11: o_data_out = 2'b11;
            // 'z' states in 'o_tri_bus' are implicitly handled by 'casez' matching rules.
            // The default assignment above ensures 'o_data_out' always has a defined value.
        endcase
    end

endmodule
