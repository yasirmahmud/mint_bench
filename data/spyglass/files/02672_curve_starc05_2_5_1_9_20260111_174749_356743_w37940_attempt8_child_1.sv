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

    // Use the internal wire in a casez statement selection expression
    // This resolves STARC05-2.5.1.9 by not using the 'tri' output directly
    always @(*) begin
        casez (w_internal_tri_state_logic) 
            1'b0: r_case_result = 1'b0;
            1'b1: r_case_result = 1'b1;
            default: r_case_result = 1'bx; // Covers 'z' and 'x' on w_internal_tri_state_logic, preventing a latch
        endcase
    end

    // Assign internal register to a regular output to ensure it is used
    assign o_regular_out = r_case_result;

endmodule
