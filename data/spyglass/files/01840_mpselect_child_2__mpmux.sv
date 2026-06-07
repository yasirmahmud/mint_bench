module mpmux (
    input        mcant,
    input  [26:0] mcan,
    input        mcanmi,
    input        negsel,
    input  [1:0] mselx,
    output [27:0] mp
);
    // This module selects the appropriate multiplicand (0*M, 1*M, or 2*M) and applies negation.
    // The 1-bit inputs 'mcant' and 'mcanmi' are interpreted as extension bits for 'mcan'
    // to form the full 28-bit multiplicand terms, resolving 'declared but not read' violations.

    wire [27:0] M_val;          // Represents 1 * M
    wire [27:0] twoM_val;       // Represents 2 * M
    wire [27:0] selected_abs_val; // The absolute selected multiplicand term
    wire [27:0] negated_val;    // The final multiplicand term after negation

    // Interpret 'mcant' as the MSB (e.g., sign extension bit) and 'mcan' as the lower bits for 1*M.
    assign M_val = {mcant, mcan};

    // Interpret 'mcan' as the upper bits and 'mcanmi' as the LSB (e.g., fractional bit) for 2*M.
    // This is equivalent to shifting M_val left by 1 if M_val was {mcant, mcan, mcanmi}.
    assign twoM_val = {mcan, mcanmi};

    // Select the absolute value of the multiplicand term based on 'mselx'
    case (mselx)
        2'b00: selected_abs_val = 28'b0;      // Selects 0 * M
        2'b01: selected_abs_val = M_val;      // Selects 1 * M
        2'b10: selected_abs_val = twoM_val;   // Selects 2 * M
        default: selected_abs_val = 28'b0;    // Default case for completeness, mselx is 2-bit
    endcase

    // Apply two's complement negation if 'negsel' is active
    assign negated_val = negsel ? (~selected_abs_val + 28'd1) : selected_abs_val;

    // Assign the final (possibly negated) multiplicand term to the output
    assign mp = negated_val;
endmodule
