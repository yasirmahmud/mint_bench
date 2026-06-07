module sky130_fd_sc_hd__or4b (
    X,
    A,
    B,
    C,
    D_N,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output X;
    input A;
    input B;
    input C;
    input D_N;
    input VPWR;
    input VGND;
    input VPB;
    input VNB;

    // Functional behavior for an OR4B gate, where one input (D_N in this case)
    // is inverted before the OR operation. This aligns with the wrapper's description
    // "connecting inputs A, B, C, and inverted D_N".
    assign X = A | B | C | (~D_N);

endmodule
