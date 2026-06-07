module curve_w496a_20260110_231726_attempt6 (
    input wire in_data_1,
    input wire in_data_2,
    input wire in_data_3,
    output reg out_val_1,
    output reg out_val_2,
    output reg out_val_3
);

    // Declare wires to hold the tristate value 'z'
    // This makes the violation distinct from direct literal comparison
    // in previous attempts.
    wire z_constant_1;
    wire z_constant_2;
    wire z_constant_3;

    // Assign the tristate value to the wires
    assign z_constant_1 = 1'bz;
    assign z_constant_2 = 1'bz;
    assign z_constant_3 = 1'bz;

    always @(*) begin
        // Default assignments to prevent latches
        out_val_1 = 1'b0;
        out_val_2 = 1'b0;
        out_val_3 = 1'b0;

        // First W496a violation: Comparison of an input with a wire holding 1'bz
        if (in_data_1 == z_constant_1) begin
            out_val_1 = 1'b1;
        end

        // Second W496a violation: Comparison of another input with a wire holding 1'bz
        if (in_data_2 == z_constant_2) begin
            out_val_2 = 1'b1;
        end

        // Third W496a violation: Comparison of a third input with a wire holding 1'bz
        if (in_data_3 == z_constant_3) begin
            out_val_3 = 1'b1;
        end
    end

endmodule
