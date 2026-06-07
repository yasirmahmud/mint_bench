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

    // Resolve W240 warnings for unused power/ground inputs.
    // These inputs are critical for physical implementation but not used in the logical assign statement.
    // Assigning them to a dummy wire satisfies the linter without affecting functional behavior.
    wire _unused_power_inputs_ = VPWR | VGND | VPB | VNB;

endmodule
