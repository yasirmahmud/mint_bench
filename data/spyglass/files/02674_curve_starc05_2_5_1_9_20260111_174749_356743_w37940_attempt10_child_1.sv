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

    // The original code used the tri-state output 'o_tristate_output' in the selection expression
    // of a casez statement, which triggers STARC05-2.5.1.9 violation.
    // To fix this, we'll implement the equivalent logic directly using the input signals
    // i_enable and i_data_in, maintaining the original functional behavior.
    always @(*) begin
        if (i_enable) begin
            // When i_enable is high, o_tristate_output is 'z'.
            // The original 'casez' default branch would catch 'z' and assign 1'bx.
            r_temp_result = 1'bx;
        end else begin
            // When i_enable is low, o_tristate_output is i_data_in.
            // We now check i_data_in directly.
            if (i_data_in == 1'b0) begin
                r_temp_result = 1'b0;
            end else if (i_data_in == 1'b1) begin
                r_temp_result = 1'b1;
            end else begin
                // Catches 'x' (and implicitly 'z' if i_data_in could be 'z', though inputs typically aren't).
                // This mirrors the original 'default' behavior for i_data_in being 'x'.
                r_temp_result = 1'bx;
            end
        end
    end

    // Connect the internal result to a top-level output to ensure it is used
    // and to avoid an unused signal warning for r_temp_result.
    assign o_processed_data = r_temp_result;

endmodule
