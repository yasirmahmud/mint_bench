module curve_w505_20260111_231001_919182_w15680_attempt11 (
    input wire in_a,
    input wire in_b,
    input wire sel,
    output reg out_data
);

reg P3; // P3 is the target signal for the W505 violation

always @(*) begin
    // Blocking assignment to P3
    P3 = in_a;

    // Non-blocking assignment to P3 under a condition
    if (sel) begin
        P3 <= in_b;
    end
end

// Use P3 to avoid an unused signal warning
assign out_data = P3;

endmodule
