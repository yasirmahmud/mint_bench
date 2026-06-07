module curve_w505_20260111_154454_070843_w30032_attempt6 (
    input wire [7:0] in_data,
    input wire sel,
    output reg [7:0] P3
);

// Rule W505: Variable/Signal 'P3' is being assigned in both blocking and non-blocking manner
// The original code attempted to trigger W505 by mixing blocking and non-blocking assignments
// to the same 'reg' signal P3. Functionally, both branches assigned 'in_data' to P3.
// To resolve the W505 and SYNTH_77 violations, P3 is now assigned consistently
// using a single blocking assignment, preserving the functional behavior that P3 always takes the value of in_data.
always @(*) begin
    P3 = in_data; // Consistent blocking assignment
end

endmodule
