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

    // Define the first tri-state output
    assign o_tri_state_0 = i_control_0 ? i_data_0 : 1'bz;

    // Define the second tri-state output
    assign o_tri_state_1 = i_control_1 ? i_data_1 : 1'bz;

    // A single always block containing two casez statements.
    // Each casez statement uses a distinct tri-state output as its selection expression,
    // thereby triggering two separate STARC05-2.5.1.9 violations.
    always @(*) begin
        // First violation for o_tri_state_0
        casez (o_tri_state_0)
            1'b0: r_case_result_0 = 1'b0;
            1'b1: r_case_result_0 = 1'b1;
            default: r_case_result_0 = 1'bx; // Covers 'z' and 'x' on o_tri_state_0, prevents unintended latch
        endcase

        // Second violation for o_tri_state_1
        casez (o_tri_state_1)
            1'b0: r_case_result_1 = 1'b0;
            1'b1: r_case_result_1 = 1'b1;
            default: r_case_result_1 = 1'bx; // Covers 'z' and 'x' on o_tri_state_1, prevents unintended latch
        endcase
    end

    // Assign internal registers to regular outputs to ensure they are used
    assign o_regular_out_0 = r_case_result_0;
    assign o_regular_out_1 = r_case_result_1;

endmodule
