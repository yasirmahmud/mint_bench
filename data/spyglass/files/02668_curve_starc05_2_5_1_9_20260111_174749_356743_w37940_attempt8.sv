module starc05_2_5_1_9_distinct_example (
    input i_control,
    input i_data,
    output tri o_tri_state_val,
    output wire o_regular_out
);

    reg r_case_result;

    // Define the tri-state output
    assign o_tri_state_val = i_control ? i_data : 1'bz;

    // Use the tri-state output in a casez statement selection expression
    // This line specifically triggers STARC05-2.5.1.9
    always @(*) begin
        casez (o_tri_state_val) 
            1'b0: r_case_result = 1'b0;
            1'b1: r_case_result = 1'b1;
            default: r_case_result = 1'bx; // Covers 'z' and 'x' on o_tri_state_val, preventing a latch
        endcase
    end

    // Assign internal register to a regular output to ensure it is used
    assign o_regular_out = r_case_result;

endmodule
