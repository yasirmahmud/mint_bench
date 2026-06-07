module curve_w505_20260111_154454_070843_w30032_attempt6 (
    input wire [7:0] in_data,
    input wire sel,
    output reg [7:0] P3
);

// Rule W505: Variable/Signal 'P3' is being assigned in both blocking and non-blocking manner
// This example attempts to trigger W505 by mixing blocking and non-blocking assignments
// to the same 'reg' signal P3 within a combinational 'always @(*)' block.
// This approach is intended to be distinct from previous attempts that used sequential blocks
// and to potentially avoid rules like W336, which specifically target blocking assignments
// within 'FlipFlop inferred sequential blocks'.
// Using a non-blocking assignment in a combinational 'always @(*)' block is generally
// considered unconventional and may trigger other warnings related to latches or style.
always @(*) begin
    if (sel) begin
        P3 = in_data;    // Blocking assignment to P3
    end else begin
        P3 <= in_data;   // Non-blocking assignment to P3
    end
end

endmodule
