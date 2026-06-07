module curve_w502_20260111_115546_attempt9 (
    input wire enable,
    output reg out_signal
);

    // This module aims to trigger exactly one W502 violation.
    // Rule: W502 - The signal/variable 'iv_mux_out' is modified inside always block.
    // Context examples show latches with the output in the sensitivity list, where both
    // the data assignment (e.g., 'q <= d;') and the self-assignment (e.g., 'q <= q;')
    // are typically flagged. This usually leads to two W502 violations per standard explicit latch.
    //
    // Attempt 8, with a simple combinational assignment (`out_reg = in_data;` in `always @(in_data)`),
    // did not trigger W502. This indicates that W502 is not triggered by every assignment.
    // The successful context examples consistently include the output signal in the sensitivity list
    // and form latches.
    //
    // This attempt creates a latch by including `out_signal` in the sensitivity list
    // and providing only ONE explicit assignment statement to `out_signal` within the block:
    // a self-assignment (`out_signal = out_signal;`).
    //
    // Hypothesis for achieving a single W502 violation:
    // 1. W502 is triggered when a `reg` type signal is in the sensitivity list of an `always` block
    //    and is assigned within that block (characteristic of a latch).
    // 2. An explicit self-assignment (`signal = signal;`) counts as a "modification" that triggers W502.
    // 3. By providing only this single explicit assignment, we aim for exactly one violation.
    //    The implicit latch created when 'enable' is true does not involve an explicit assignment
    //    in that branch and therefore, based on the rule phrasing "is modified", is expected NOT
    //    to trigger an additional W502 violation (though it might trigger an InferLatch rule).
    always @(enable or out_signal) begin
        if (!enable) begin
            out_signal = out_signal; // This is the single explicit modification.
                                     // It is intended to trigger W502 exactly once.
        end
        // When 'enable' is true, 'out_signal' is not assigned within this branch,
        // implicitly creating a latch. This path is expected NOT to trigger W502
        // as no explicit 'modification' statement is present here.
    end

endmodule
