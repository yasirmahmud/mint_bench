module curve_starc05_2_5_1_9_20260112_002053_346853_w47152_attempt14 (
    input wire i_en,
    input wire i_data,
    output tri o_tri_state_output,
    output reg o_casez_result,
    output reg o_casex_result
);

    // Drive the tri-state output. This signal, when its bits are 'z', will cause the violations.
    assign o_tri_state_output = i_en ? i_data : 1'bz;

    // First violation: Using 'o_tri_state_output' in a casez selection expression.
    // If o_tri_state_output is 1'bz, it won't match 1'b0 or 1'b1, so o_casez_result will retain its default value of 1'b0.
    always @(*) begin
        o_casez_result = 1'b0; // Default assignment to prevent latches and NoAssignX-ML

        casez (o_tri_state_output)
            1'b0: o_casez_result = 1'b0;
            1'b1: o_casez_result = 1'b1;
        endcase
    end

    // Second violation: Using 'o_tri_state_output' in a casex selection expression.
    // If o_tri_state_output is 1'bz, casex treats 'z' in the selector as a wildcard and matches the first case item (1'b0).
    always @(*) begin
        o_casex_result = 1'b1; // Default assignment to prevent latches and NoAssignX-ML

        casex (o_tri_state_output)
            1'b0: o_casex_result = 1'b1;
            1'b1: o_casex_result = 1'b0;
        endcase
    end

endmodule
