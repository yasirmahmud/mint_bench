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

    // A single always block containing logic to derive r_case_result_X based on inputs.
    // This resolves STARC05-2.5.1.9 violations by not using tri-state outputs 
    // (or wires derived from them) in the selection expression of casez statements.
    always @(*) begin
        // Determine r_case_result_0 based on i_control_0 and i_data_0
        if (i_control_0 == 1'b1) begin // When the tri-state output o_tri_state_0 is actively driven by i_data_0
            casez (i_data_0)
                1'b0: r_case_result_0 = 1'b0;
                1'b1: r_case_result_0 = 1'b1;
                default: r_case_result_0 = 1'bx; // Covers 'x' and 'z' on i_data_0
            endcase
        end else begin // i_control_0 is 0, x, or z, meaning o_tri_state_0 would be 'z' or 'x'
            r_case_result_0 = 1'bx;
        end

        // Determine r_case_result_1 based on i_control_1 and i_data_1
        if (i_control_1 == 1'b1) begin // When the tri-state output o_tri_state_1 is actively driven by i_data_1
            casez (i_data_1)
                1'b0: r_case_result_1 = 1'b0;
                1'b1: r_case_result_1 = 1'b1;
                default: r_case_result_1 = 1'bx; // Covers 'x' and 'z' on i_data_1
            endcase
        end else begin // i_control_1 is 0, x, or z, meaning o_tri_state_1 would be 'z' or 'x'
            r_case_result_1 = 1'bx;
        end
    end

    // Assign internal registers to regular outputs to ensure they are used
    assign o_regular_out_0 = r_case_result_0;
    assign o_regular_out_1 = r_case_result_1;

endmodule
