module curve_w502_20260111_230044_971245_w32456_attempt12 (
    input wire en,
    input wire d,
    output reg q
);

    // This always block infers a latch for 'q'.
    // The explicit self-assignment 'q = q;' is expected to trigger W502
    // because the signal 'q' is explicitly "modified" inside the always block,
    // even though its value remains unchanged.
    always @(en or d or q) begin
        if (en) begin
            q = d;
        end else begin
            // Target for W502: The signal 'q' is explicitly modified with its own value
            // inside this always block. This is distinct from previous attempt
            // as it's within a combinational sensitivity list (latch inference),
            // thereby avoiding W336.
            q = q; 
        end
    end

endmodule
