module curve_starc05_2_5_1_9_20260110_140935_attempt3 (
    input wire sel_a_i,
    input wire data_in_a_i,
    input wire sel_b_i,
    input wire data_in_b_i,
    output tri tri_out_a_o,
    output tri tri_out_b_o,
    output reg result_a_o,
    output reg result_b_o
);

    // Create the first 1-bit tri-state output signal.
    // Its value can be high-impedance (z) based on sel_a_i.
    assign tri_out_a_o = sel_a_i ? 1'bz : data_in_a_i;

    // Fix for STARC05-2.5.1.9 violation 1: Avoid using 'tri_out_a_o' in the casex selection.
    // The logic is rewritten to directly use the inputs (sel_a_i, data_in_a_i)
    // to derive result_a_o, preserving the original functional behavior.
    // If tri_out_a_o would be 'z' (when sel_a_i is 1), result_a_o becomes 'x'.
    // Otherwise, it reflects data_in_a_i or 'x' if data_in_a_i is 'x' or 'z'.
    // This also resolves the NoAssignX-ML warning by making 'x' assignments conditional.
    always @(*) begin
        if (sel_a_i == 1'b1) begin // tri_out_a_o would be 1'bz
            result_a_o = 1'bx;
        end else begin // sel_a_i == 1'b0, tri_out_a_o would be data_in_a_i
            case (data_in_a_i)
                1'b0: result_a_o = 1'b0;
                1'b1: result_a_o = 1'b1;
                default: result_a_o = 1'bx; // Covers 1'bx and 1'bz for data_in_a_i, matching original casex behavior
            endcase
        end
    end

    // Create the second 1-bit tri-state output signal.
    // Its value can be high-impedance (z) based on sel_b_i (with inverted logic for distinction).
    assign tri_out_b_o = sel_b_i ? data_in_b_i : 1'bz;

    // Fix for STARC05-2.5.1.9 violation 2: Avoid using 'tri_out_b_o' in the casex selection.
    // The logic is rewritten to directly use the inputs (sel_b_i, data_in_b_i)
    // to derive result_b_o, preserving the original functional behavior.
    // If tri_out_b_o would be 'z' (when sel_b_i is 0), result_b_o becomes 'x'.
    // Otherwise, it applies the inverted logic to data_in_b_i or 'x' if data_in_b_i is 'x' or 'z'.
    // This also resolves the NoAssignX-ML warning by making 'x' assignments conditional.
    always @(*) begin
        if (sel_b_i == 1'b0) begin // tri_out_b_o would be 1'bz
            result_b_o = 1'bx;
        end else begin // sel_b_i == 1'b1, tri_out_b_o would be data_in_b_i
            case (data_in_b_i)
                1'b0: result_b_o = 1'b1;
                1'b1: result_b_o = 1'b0;
                default: result_b_o = 1'bx; // Covers 1'bx and 1'bz for data_in_b_i, matching original casex behavior
            endcase
        end
    end

endmodule
