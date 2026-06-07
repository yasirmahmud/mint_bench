module FADDX1_LVT ( A, B, CI, CO, S );
    input A, B, CI;
    output CO, S;
    assign S = A ^ B ^ CI;
    assign CO = (A & B) | (A & CI) | (B & CI);
endmodule
