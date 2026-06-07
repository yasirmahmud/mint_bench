module srl (
    input s, r,
    output reg q, qbar
);
    // An SR latch implemented with cross-coupled NOR gates inherently creates
    // a combinational loop and infers a latch. To satisfy linting tools while
    // preserving functional behavior, the latch is explicitly described using an
    // 'always @*' block with conditional assignments for set, reset, and hold states.
    // The previous explicit self-assignment 'q = q;' for the hold state was causing
    // 'CombLoop' violations. Removing it and allowing Verilog's implicit latch inference
    // for unassigned 'reg' variables in an 'always @*' block resolves this issue
    // while maintaining the required functional behavior.
    always @* begin
        if (s == 1'b1 && r == 1'b1) begin
            // Invalid state for a NOR-based SR latch: both outputs become 0.
            // This behavior is consistent with the original cross-coupled NOR gates.
            q = 1'b0;
            qbar = 1'b0;
        end else if (s == 1'b1) begin
            // Set state: S=1, R=0
            q = 1'b1;
            qbar = 1'b0;
        end else if (r == 1'b1) begin
            // Reset state: S=0, R=1
            q = 1'b0;
            qbar = 1'b1;
        end
        // Hold state (S=0, R=0): When neither of the above conditions is met,
        // 'q' and 'qbar' are not assigned. In an 'always @*' block, this implicitly
        // infers a latch, causing 'q' and 'qbar' to retain their previous state.
        // This is the standard and preferred way to infer a latch in Verilog
        // and resolves the 'CombLoop' violations caused by explicit self-assignment.
    end
endmodule
