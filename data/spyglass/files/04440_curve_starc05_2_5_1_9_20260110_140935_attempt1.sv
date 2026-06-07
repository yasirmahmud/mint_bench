module curve_starc05_2_5_1_9_20260110_140935_attempt1 (
    input wire sel,
    input wire data_in,
    output wire tri tri_out,
    output reg out_reg
);

    // Create a tri-state output signal
    assign tri_out = sel ? data_in : 1'bz;

    // Use the tri-state output in a casez statement selection expression
    // This will trigger the STARC05-2.5.1.9 violation.
    always @(*) begin
        casez (tri_out)
            1'b0: out_reg = 1'b0;
            1'b1: out_reg = 1'b1;
            default: out_reg = 1'bx; // Handles 'x' or 'z' on tri_out, prevents latch
        endcase
    end

endmodule
