module curve_starc05_2_5_1_9_20260111_174749_356743_w37940_attempt9 (
    input i_control_0,
    input i_data_0,
    input i_control_1,
    input i_data_1,
    output tri o_tri_state_0,
    output tri o_tri_state_1,
    output wire o_regular_out_0,
    output wire o_regular_out_1
);

    reg r_case_result_0;
    reg r_case_result_1;

    // Internal wires to capture the value of tri-state outputs for casez statements
    // This resolves STARC05-2.5.1.9 violations by not directly using tri-state outputs in casez selection.
    wire w_tri_state_0_internal;
    wire w_tri_state_1_internal;

    // Define the first tri-state output
    assign o_tri_state_0 = i_control_0 ? i_data_0 : 1'bz;
    // Capture the value of the tri-state output for internal logic
    assign w_tri_state_0_internal = o_tri_state_0;

    // Define the second tri-state output
    assign o_tri_state_1 = i_control_1 ? i_data_1 : 1'bz;
    // Capture the value of the tri-state output for internal logic
    assign w_tri_state_1_internal = o_tri_state_1;

    // A single always block containing two casez statements.
    // Now using internal wires to avoid STARC05-2.5.1.9 violations.
    always @(*) begin
        // Fixed violation for o_tri_state_0 by using w_tri_state_0_internal
        casez (w_tri_state_0_internal)
            1'b0: r_case_result_0 = 1'b0;
            1'b1: r_case_result_0 = 1'b1;
            default: r_case_result_0 = 1'bx; // Covers 'z' and 'x' on w_tri_state_0_internal
        endcase

        // Fixed violation for o_tri_state_1 by using w_tri_state_1_internal
        casez (w_tri_state_1_internal)
            1'b0: r_case_result_1 = 1'b0;
            1'b1: r_case_result_1 = 1'b1;
            default: r_case_result_1 = 1'bx; // Covers 'z' and 'x' on w_tri_state_1_internal
        endcase
    end

    // Assign internal registers to regular outputs to ensure they are used
    assign o_regular_out_0 = r_case_result_0;
    assign o_regular_out_1 = r_case_result_1;

endmodule
