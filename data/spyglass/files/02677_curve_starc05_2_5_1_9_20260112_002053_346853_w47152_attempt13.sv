module curve_starc05_2_5_1_9_20260112_002053_346853_w47152_attempt13 (
    input wire i_en,
    input wire i_data,
    output tri o_tri_state_output,
    output reg o_case_result_a,
    output reg o_case_result_b
);

    // Drive the tri-state output. This signal will cause the violations.
    assign o_tri_state_output = i_en ? i_data : 1'bz;

    // This always block contains two statements, each causing a violation.
    // Both use the tri-state output in their selection expression.
    always @(*) begin
        // Default assignments to prevent latches
        o_case_result_a = 1'bx;
        o_case_result_b = 1'bx;

        // First violation: Using 'o_tri_state_output' in a casez selection expression
        casez (o_tri_state_output)
            1'b0: o_case_result_a = 1'b0;
            1'b1: o_case_result_a = 1'b1;
            default: o_case_result_a = 1'b0;
        endcase

        // Second violation: Using 'o_tri_state_output' in a casex selection expression
        casex (o_tri_state_output)
            1'b0: o_case_result_b = 1'b1;
            1'b1: o_case_result_b = 1'b0;
            default: o_case_result_b = 1'b1;
        endcase
    end

endmodule
