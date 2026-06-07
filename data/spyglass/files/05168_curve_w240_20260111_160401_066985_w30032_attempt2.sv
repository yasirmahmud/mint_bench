module curve_w240_20260111_160401_066985_w30032_attempt2 (
    input [3:0] in_a,
    input [3:0] in_b,
    input enable, // This input will be declared but not read.
    output [3:0] out_sum
);

// Simple combinatorial logic that does not use 'enable'.
assign out_sum = in_a + in_b;

endmodule
