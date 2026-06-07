module fpu_booth (
    output [1:0] mselx,
    output       negsel,
    input  [2:0] bits,
    output       signbit
);
    // Implementation of radix-4 Booth recoding based on 'bits[2:0]'
    // 'bits[2]' (y_i+1), 'bits[1]' (y_i), 'bits[0]' (y_i-1)

    // negsel: Indicates a negative multiplicand (1 for -1*M, -2*M)
    // This is true for input bit combinations 100, 101, 110.
    assign negsel = (bits == 3'b100) | (bits == 3'b101) | (bits == 3'b110);

    // mselx: Encodes the absolute magnitude of the multiplicand (0, 1, or 2)
    // 2'b00 (0*M): for 000, 111
    // 2'b01 (1*M): for 001, 010, 101, 110
    // 2'b10 (2*M): for 011, 100
    assign mselx[0] = (bits == 3'b001) | (bits == 3'b010) | (bits == 3'b101) | (bits == 3'b110);
    assign mselx[1] = (bits == 3'b011) | (bits == 3'b100);

    // signbit: As per the description, another sign bit output. Assuming it's the same as negsel.
    assign signbit = negsel;
endmodule
