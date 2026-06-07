module curve_starc05_2_5_1_9_20260111_215500_837773_w32456_attempt11 (
    input wire i_data_in,
    input wire i_enable_tri,
    output wire o_tri_state_output,
    output reg o_case_result_a,
    output reg o_case_result_b
);

    // Declare and drive a tri-state output signal
    assign o_tri_state_output = i_enable_tri ? i_data_in : 1'bz;

    // First violation: Using the tri-state output in a casez selection expression
    always @(*) begin
        casez (o_tri_state_output)
            1'b0: o_case_result_a = 1'b0;
            1'b1: o_case_result_a = 1'b1;
            default: o_case_result_a = 1'b0; // Ensures o_case_result_a is always driven, preventing a latch
        endcase
    end

    // Second violation: Using the tri-state output in a casex selection expression
    always @(*) begin
        casex (o_tri_state_output)
            1'b0: o_case_result_b = 1'b1;
            1'b1: o_case_result_b = 1'b0;
            default: o_case_result_b = 1'b1; // Ensures o_case_result_b is always driven, preventing a latch
        endcase
    end

endmodule
