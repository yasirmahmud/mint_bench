module curve_w502_20260111_115546_attempt5 (
    output reg q
);

    // This always block contains a self-assignment for 'q'.
    // The W502 rule targets signals 'modified inside always block'.
    // Previous attempts yielded two W502 violations when both a data input and self-assignment were present.
    // By isolating only the self-assignment, the goal is to trigger exactly one W502 violation,
    // specifically highlighting the explicit assignment of a signal to itself within the block,
    // which is often a key aspect of how this rule is triggered based on the provided examples.
    always @(q) begin
        q = q; // This explicit self-assignment modifies 'q' inside the always block, triggering W502.
    end

endmodule
