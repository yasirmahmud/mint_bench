module curve_starc05_2_5_1_9_20260111_174749_356743_w37940_attempt10 (
    input i_enable,
    input i_data_in,
    output tri o_tristate_output,
    output wire o_processed_data
);

    reg r_temp_result;

    // Define a tri-state output. This will be the source of the violation.
    // If i_enable is high, the output is high-impedance ('z'), otherwise it passes i_data_in.
    assign o_tristate_output = i_enable ? 1'bz : i_data_in;

    // Use the tri-state output 'o_tristate_output' in the selection expression
    // of a casez statement. This directly triggers one STARC05-2.5.1.9 violation.
    // The default case ensures r_temp_result is always driven, preventing a latch.
    always @(*) begin
        casez (o_tristate_output)
            1'b0: r_temp_result = 1'b0;
            1'b1: r_temp_result = 1'b1;
            default: r_temp_result = 1'bx; // Catches 'z' and 'x' on o_tristate_output
        endcase
    end

    // Connect the internal result to a top-level output to ensure it is used
    // and to avoid an unused signal warning for r_temp_result.
    assign o_processed_data = r_temp_result;

endmodule
