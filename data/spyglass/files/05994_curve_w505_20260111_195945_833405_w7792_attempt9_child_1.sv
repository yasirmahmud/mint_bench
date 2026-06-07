module curve_w505_20260111_195945_833405_w7792_attempt9 (
    input wire [7:0] in_a,
    input wire [7:0] in_b,
    output reg [7:0] P3
);

// Original intent: The mixed blocking and non-blocking assignments to 'P3' in the same
// combinational block would typically result in 'P3' taking the value of 'in_b'
// at the end of the simulation delta cycle. To resolve W505, W415a, and SYNTH_77
// violations, and maintain this intended combinational behavior, 'P3' is assigned
// directly using a single blocking assignment.
always @* begin
    P3 = in_b;
end

endmodule
