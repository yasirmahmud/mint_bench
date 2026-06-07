module curve_w505_20260111_195945_833405_w7792_attempt9 (
    input wire clk,
    input wire [7:0] in_a,
    input wire [7:0] in_b,
    output reg [7:0] P3
);

// The variable 'P3' is assigned using both blocking ('=') and non-blocking ('<=') assignments
// within the same combinational always block. This directly triggers rule W505.
// This structure avoids inferring a flip-flop, thus mitigating W336, and ensures 'P3'
// is driven by a single always block, avoiding multiple driver issues from separate blocks.
always @* begin
    P3 = in_a;    // Blocking assignment
    P3 <= in_b;   // Non-blocking assignment
end

endmodule
