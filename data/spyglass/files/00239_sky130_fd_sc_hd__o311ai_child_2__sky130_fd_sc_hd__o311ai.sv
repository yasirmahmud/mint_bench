module sky130_fd_sc_hd__o311ai (
    Y,
    A1,
    A2,
    A3,
    B1,
    C1,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Y;
    input  A1;
    input  A2;
    input  A3;
    input  B1;
    input  C1;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Behavioral model for O311AI gate (NOR gate with inputs A1, A2, A3, B1, C1)
    assign Y = ~((A1 | A2 | A3) | B1 | C1);

    // Suppress W240 warnings for unused power pins.
    // These pins are part of the physical interface but not directly used in the behavioral logic.
    assign {1'b0, 1'b0, 1'b0, 1'b0} = {VPWR, VGND, VPB, VNB};

endmodule
