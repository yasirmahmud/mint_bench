module srl (
    input s, r,
    output reg q, qbar
);
    // An SR latch implemented with cross-coupled NOR gates inherently creates
    // a combinational loop and infers a latch. To satisfy linting tools while
    // preserving functional behavior, the latch is explicitly described using an
    // 'always @*' block with conditional assignments for set, reset, and hold states.
    // This method is often preferred by synthesis and linting tools over implicit
    // latch inference from continuous assign statements that form a loop.
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
        end else begin
            // Hold state: S=0, R=0
            // The latch retains its previous state. Explicitly assigning to itself
            // is a common way to inform synthesis tools about latch inference
            // and often resolves 'CombLoop' violations by making the latch inference explicit.
            q = q;
            qbar = qbar;
        end
    end
endmodule
