module curve_w339a_20260111_185304_096466_w53504_attempt7 (
    input [1:0] a,
    input [1:0] b
);

    // W339a: Operator '!==' should be avoided in synthesis logic
    // The 'case inequality' operator ('!==') considers X and Z values.
    // While initial blocks are typically non-synthesizable, linting tools
    // can still flag the presence of this operator anywhere, including
    // non-synthesizable contexts, to ensure consistent coding style or
    // to warn against its potential misapplication if logic were to be
    // later moved to a synthesizable block. Placing it here aims to trigger
    // W339a specifically, while avoiding synthesis-specific warnings like SYNTH_5059.
    initial begin
        if (a !== b) begin
            // This comparison is for illustrative purposes and has no effect
            // on synthesized hardware. It serves only to demonstrate the rule violation.
            $display("Warning: a is not case-equal to b (W339a trigger)");
        end
    end

endmodule
