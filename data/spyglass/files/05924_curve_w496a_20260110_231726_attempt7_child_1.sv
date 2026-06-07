module curve_w496a_20260110_231726_attempt7 (
    input wire in_a,
    input wire in_b,
    input wire in_c,
    output reg out_x,
    output reg out_y,
    output reg out_z
);

    always @(*) begin
        // Default assignments to prevent latches
        // As per SpyGlass rules (W496a, SYNTH_5034),
        // comparisons to 'z' (e.g., in_a == 1'bz) are treated as false in synthesis.
        // Therefore, the original 'if' blocks would never execute in hardware.
        // The functional behavior of the design in synthesis is that out_x, out_y, out_z
        // are always 1'b0. This fix explicitly reflects that synthesized behavior.
        out_x = 1'b0;
        out_y = 1'b0;
        out_z = 1'b0;
    end

endmodule
