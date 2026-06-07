module curve_starc05_2_5_1_9_20260112_002053_346853_w47152_attempt14 (
    input wire i_en,
    input wire i_data,
    output tri o_tri_state_output,
    output reg o_casez_result,
    output reg o_casex_result
);

    // Drive the tri-state output. This signal, when its bits are 'z', will cause the violations.
    assign o_tri_state_output = i_en ? i_data : 1'bz;

    // Helper function to resolve a 1-bit wire into a standard 2-bit code:
    // 2'b01 for 1'b1
    // 2'b00 for 1'b0
    // 2'b10 for 1'bx or 1'bz (representing an indeterminate state for comparison)
    // This function ensures that comparisons are made with definite 0/1 values,
    // avoiding X-propagation from standard '==' operator when comparing with 'x' or 'z'.
    function automatic [1:0] get_resolved_val;
        input wire signal_in;
        begin
            case (signal_in)
                1'b1: get_resolved_val = 2'b01;
                1'b0: get_resolved_val = 2'b00;
                default: get_resolved_val = 2'b10; // Treat 'x' and 'z' as an 'indeterminate' state
            endcase
        end
    endfunction

    // Resolved First violation: Using 'o_tri_state_output' in a casez selection expression.
    // Replaced the '===' operator with a check on the resolved value from the helper function.
    // This preserves the functional behavior where 'o_casez_result' is 1'b1 only if 'o_tri_state_output' is strictly 1'b1,
    // and 1'b0 otherwise (including 1'b0, 1'bx, and 1'bz).
    always @(*) begin
        if (get_resolved_val(o_tri_state_output) == 2'b01) begin // Checks if o_tri_state_output is strictly 1'b1
            o_casez_result = 1'b1;
        end else begin // Covers 1'b0, 1'bx, and 1'bz cases
            o_casez_result = 1'b0;
        end
    end

    // Resolved Second violation: Using 'o_tri_state_output' in a casex selection expression.
    // Replaced the '===' operator with a check on the resolved value from the helper function.
    // This preserves the functional behavior where 'o_casex_result' is 1'b0 only if 'o_tri_state_output' is strictly 1'b1,
    // and 1'b1 otherwise (including 1'b0, 1'bx, and 1'bz).
    always @(*) begin
        if (get_resolved_val(o_tri_state_output) == 2'b01) begin // Checks if o_tri_state_output is strictly 1'b1
            o_casex_result = 1'b0;
        end else begin // Covers 1'b0, 1'bx, and 1'bz cases
            o_casex_result = 1'b1;
        end
    end

endmodule
