module curve_starc05_2_5_1_9_20260112_002053_346853_w47152_attempt16 (
    input wire i_enable,
    input wire i_data_in,
    output tri o_tristate_output,
    output reg o_result
);

    // Drive the tri-state output. This signal will include 'z' states when i_enable is 0.
    assign o_tristate_output = i_enable ? i_data_in : 1'bz;

    // This always block will trigger exactly one STARC05-2.5.1.9 violation.
    // The tri-state output 'o_tristate_output' is used in the selection expression of a casex statement.
    always @(*) begin
        o_result = 1'b0; // Default assignment to prevent latches

        casex (o_tristate_output) // STARC05-2.5.1.9 violation will be reported on this line
            1'b0: o_result = 1'b0;
            1'b1: o_result = 1'b1;
            // When o_tristate_output is 1'bz, it will not match 1'b0 or 1'b1.
            // The 'casex' statement treats 'z' in the selector as a don't care.
            // The result is covered by the default assignment.
        endcase
    end

endmodule
