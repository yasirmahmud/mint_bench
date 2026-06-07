module curve_starc05_2_5_1_9_20260112_002053_346853_w47152_attempt15 (
    input wire i_control,
    input wire i_data,
    output tri o_tri_state_output,
    output reg o_result
);

    // Drive the tri-state output. This signal will include 'z' states.
    assign o_tri_state_output = i_control ? i_data : 1'bz;

    // This always block will trigger exactly one STARC05-2.5.1.9 violation.
    // The tri-state output 'o_tri_state_output' is used in the selection expression of a casez statement.
    always @(*) begin
        o_result = 1'b0; // Default assignment to prevent latches

        casez (o_tri_state_output) // STARC05-2.5.1.9 violation will be reported on this line
            1'b0: o_result = 1'b0;
            1'b1: o_result = 1'b1;
            // When o_tri_state_output is 1'bz, it will not match 1'b0 or 1'b1,
            // relying on the default assignment for o_result.
        endcase
    end

endmodule
