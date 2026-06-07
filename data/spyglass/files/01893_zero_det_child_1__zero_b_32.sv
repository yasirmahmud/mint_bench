// Definition for zero_b_32
module zero_b_32 (
    input  [31:0] inp,
    input         mag_a31, // This input is connected but its functional use for d_ovf is ambiguous
    output        zero_31_2,
    output        zero32,
    output        d_ovf
);
    assign zero32 = (inp == 32'd0);
    assign zero_31_2 = (inp[31:2] == 30'd0);
    assign d_ovf = (inp == 32'd0); // Division overflow if divisor (inp_b) is zero
    // Note: mag_a31 is connected to mag_a[31] and is unused in this minimal definition for d_ovf.
    // If the tool reports an unused input, further design context would be needed to define its function.
    // For now, assuming d_ovf is primarily about inp being zero, preserving the simplest interpretation.
endmodule
