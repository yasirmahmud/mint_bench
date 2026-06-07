module curve_w505_20260111_154454_070843_w30032_attempt7 (
    input wire [7:0] in_data,
    output reg [7:0] P3
);

// Rule W505: Variable/Signal 'P3' is being assigned in both blocking and non-blocking manner
// This example triggers W505 by assigning the same 'reg' signal P3
// with both blocking (=) and non-blocking (<=) assignments sequentially
// within the same combinational 'always @(*)' block.
// This approach is distinct from previous attempts that used conditional
// blocking/non-blocking assignments within the same block.
// The two assignments directly target the same variable P3 with different assignment types,
// leading to a clear violation of the rule.
always @(*) begin
    P3 = in_data;   // Blocking assignment to P3
    P3 <= in_data;  // Non-blocking assignment to P3
end

endmodule
