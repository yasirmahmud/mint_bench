// XOR2X1_LVT: 2-input XOR Gate
module XOR2X1_LVT ( A1, A2, Y );
    input A1, A2;
    output Y;
    assign Y = A1 ^ A2;
endmodule
