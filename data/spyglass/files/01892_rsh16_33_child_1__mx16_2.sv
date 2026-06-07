module mx16_2 (
    input [1:0] i0,
    input [1:0] i1,
    input [1:0] i2,
    input [1:0] i3,
    input [1:0] i4,
    input [1:0] i5,
    input [1:0] i6,
    input [1:0] i7,
    input [1:0] i8,
    input [1:0] i9,
    input [1:0] i10,
    input [1:0] i11,
    input [1:0] i12,
    input [1:0] i13,
    input [1:0] i14,
    input [1:0] i15,
    input [3:0] sel,
    output [1:0] out
);
    assign out = {i15, i14, i13, i12, i11, i10, i9, i8, i7, i6, i5, i4, i3, i2, i1, i0}[sel*2 +: 2];
endmodule
