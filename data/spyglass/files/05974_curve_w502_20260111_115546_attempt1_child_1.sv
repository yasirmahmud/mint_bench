module curve_w502_20260111_115546_attempt1 (
    input wire en,
    input wire d_in,
    output reg q_out
);

    // This always block describes a level-sensitive latch.
    // The explicit self-assignment 'q_out = q_out' in the else branch
    // was removed to resolve SpyGlass W502, relying on implicit latching behavior.
    // The sensitivity list was also adjusted to be more conventional for a latch.
    always @(en or d_in) begin
        if (en) begin
            q_out = d_in;
        end
        // If 'en' is low, q_out is not assigned and retains its previous value,
        // which is the desired latching behavior.
    end

endmodule
