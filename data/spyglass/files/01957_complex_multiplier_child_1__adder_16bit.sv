// --- Definition for adder_16bit ---
// This module performs a combinational 16-bit addition.
// The CLK and Reset inputs are included to match the instantiation interface, but are unused
// in this combinational implementation.
module adder_16bit (
    input [15:0] input_a,
    input [15:0] input_b,
    output [15:0] output_z,
    input CLK,
    input Reset
);
    assign output_z = input_a + input_b;
endmodule
