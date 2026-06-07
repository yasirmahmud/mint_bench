module mx16_1 (
    input       i0,
    input       i1,
    input       i2,
    input       i3,
    input       i4,
    input       i5,
    input       i6,
    input       i7,
    input       i8,
    input       i9,
    input       i10,
    input       i11,
    input       i12,
    input       i13,
    input       i14,
    input       i15,
    input [3:0] sel,
    output      out
);
    assign out = {i15, i14, i13, i12, i11, i10, i9, i8, i7, i6, i5, i4, i3, i2, i1, i0}[sel];
endmodule
