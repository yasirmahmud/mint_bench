module curve_w502_20260111_115546_attempt4 (
    input wire en,
    input wire d,
    output reg q
);

    // This always block implements a basic gated latch.
    // The explicit self-assignment 'q = q;' in the else branch
    // was intended to directly trigger the W502 violation, which has been removed.
    // The context examples show this specific construct (e.g., 'q <= q;')
    // as the cause for W502, often associated with explicitly holding
    // a latch's value. By removing the redundant self-assignment,
    // the implicit hold behavior of a 'reg' variable in an 'always' block
    // when not assigned in all branches is utilized, resolving the W502 violation
    // while preserving the functional behavior of a gated latch.
    always @(en or d or q) begin
        if (en) begin
            q = d;
        end
        // The 'else' branch is removed. When 'en' is false, 'q' (a 'reg')
        // will implicitly hold its value, which is the desired behavior for a latch.
    end

endmodule
