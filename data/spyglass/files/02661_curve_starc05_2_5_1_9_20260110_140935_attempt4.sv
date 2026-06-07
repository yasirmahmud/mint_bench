module curve_starc05_2_5_1_9_20260110_140935_attempt4 (
    input wire in_sel_1,
    input wire in_data_1,
    input wire in_sel_2,
    input wire in_data_2,
    output tri out_tri_1,
    output tri out_tri_2,
    output reg data_out_1,
    output reg data_out_2
);

    // Violation 1: Tri-state output 'out_tri_1' bits(s) used in the selection expression of casez statement.
    // 'out_tri_1' can be driven by 'in_data_1' or be high-impedance (z).
    assign out_tri_1 = in_sel_1 ? in_data_1 : 1'bz;

    always @(*) begin
        // Default assignment to ensure 'data_out_1' is always assigned, preventing latches and NoAssignX-ML violations.
        data_out_1 = 1'b0; 
        casez (out_tri_1) // STARC05-2.5.1.9 violation 1: 'out_tri_1' used in casez selection
            1'b0: data_out_1 = 1'b0;
            1'b1: data_out_1 = 1'b1;
            // '1'bz' (when in_sel_1 is false) is handled by casez matching rules;
            // the default assignment ensures a definite value.
        endcase
    end

    // Violation 2: Tri-state output 'out_tri_2' bits(s) used in the selection expression of casex statement.
    // 'out_tri_2' can be driven by 'in_data_2' or be high-impedance (z).
    assign out_tri_2 = in_sel_2 ? in_data_2 : 1'bz;

    always @(*) begin
        // Default assignment to ensure 'data_out_2' is always assigned, preventing latches and NoAssignX-ML violations.
        data_out_2 = 1'b1; 
        casex (out_tri_2) // STARC05-2.5.1.9 violation 2: 'out_tri_2' used in casex selection
            1'b0: data_out_2 = 1'b0;
            1'b1: data_out_2 = 1'b1;
            // '1'bx'/'1'bz' are handled by casex matching rules;
            // the default assignment ensures a definite value.
        endcase
    end

endmodule
