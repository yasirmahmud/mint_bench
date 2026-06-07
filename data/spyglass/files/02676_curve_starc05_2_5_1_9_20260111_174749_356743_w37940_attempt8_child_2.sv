module starc05_2_5_1_9_distinct_example (
    input i_control,
    input i_data,
    output tri o_tri_state_val,
    output wire o_regular_out
);

    reg r_case_result;
    wire w_internal_tri_state_logic; // Intermediate wire to hold the logic that drives o_tri_state_val

    // Define the tri-state output driver logic
    assign w_internal_tri_state_logic = i_control ? i_data : 1'bz;

    // Assign the internal logic to the actual tri-state output
    assign o_tri_state_val = w_internal_tri_state_logic;

    // Modified to resolve STARC05-2.5.1.9:
    // The original issue was using 'w_internal_tri_state_logic' (which can be 'z')
    // directly in the casez selection expression. To fix this, we'll decompose
    // the logic based on its primary inputs 'i_control' and 'i_data'.
    // This ensures that the casez selection expression does not contain 'z' values.
    always @(*) begin
        if (i_control == 1'b1) begin
            // When i_control is asserted, w_internal_tri_state_logic resolves to i_data.
            // We can now safely use i_data in the casez selection, as i_data is an input
            // and not a tri-state output.
            casez (i_data)
                1'b0: r_case_result = 1'b0;
                1'b1: r_case_result = 1'b1;
                default: r_case_result = 1'bx; // Covers 'x' and 'z' on i_data
            endcase
        end else begin
            // When i_control is deasserted (0), 'w_internal_tri_state_logic' is 1'bz.
            // When i_control is 'x' or 'z', 'w_internal_tri_state_logic' is typically 'x'.
            // In the original design, both these scenarios led to the default branch
            // of the casez statement, setting r_case_result to 1'bx.
            r_case_result = 1'bx;
        end
    end

    // Assign internal register to a regular output to ensure it is used
    assign o_regular_out = r_case_result;

endmodule
