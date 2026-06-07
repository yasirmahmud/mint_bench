module curve_w502_20260111_115546_attempt4 (
    input wire en,
    input wire d,
    output reg q
);

    // This always block implements a basic gated latch.
    // The explicit self-assignment 'q = q;' in the else branch
    // is intended to directly trigger the W502 violation.
    // The context examples show this specific construct (e.g., 'q <= q;')
    // as the cause for W502, often associated with explicitly holding
    // a latch's value.
    always @(en or d or q) begin
        if (en) begin
            q = d;
        end else begin
            q = q; // The signal 'q' is modified by assigning itself, triggering W502.
        end
    end

endmodule
