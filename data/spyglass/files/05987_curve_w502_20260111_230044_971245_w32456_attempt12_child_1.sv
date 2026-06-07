module curve_w502_20260111_230044_971245_w32456_attempt12 (
    input wire en,
    input wire d,
    output reg q
);

    // This always block infers a latch for 'q'.
    // To resolve W502 violations and ensure correct latch inference:
    // 1. The sensitivity list was changed from `always @(en or d or q)` to `always @(en or d)`.
    //    Including `q` in the sensitivity list for a combinational block where `q` is also assigned
    //    can lead to warnings (like W502 or combinational loop warnings) and potential simulation mismatches.
    // 2. The explicit self-assignment `q = q;` in the `else` branch was removed.
    //    For a latch, not assigning `q` when the enable is low is the standard way to infer
    //    the hold behavior, avoiding unnecessary explicit modifications that trigger W502.
    always @(en or d) begin
        if (en) begin
            q = d; // 'q' is assigned 'd' when enabled
        end else begin
            // When 'en' is low, 'q' is left unassigned within this block.
            // This implicitly infers a latch, causing 'q' to hold its previous value.
            // The explicit `q = q;` was removed to resolve W502.
        end
    end

endmodule
