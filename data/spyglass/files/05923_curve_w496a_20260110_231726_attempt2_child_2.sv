module curve_w496a_20260110_231726_attempt2 (
    input wire a,
    output wire out
);

    // Fix for SpyGlass W240: Input 'a' declared but not read.
    // Assign 'a' to a dummy wire to consume it without affecting the output behavior.
    wire unused_a;
    assign unused_a = a;

    assign out = 1'b0;

endmodule
