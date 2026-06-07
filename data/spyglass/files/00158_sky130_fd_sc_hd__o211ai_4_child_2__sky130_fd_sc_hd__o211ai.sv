module sky130_fd_sc_hd__o211ai (
    Y,
    A1,
    A2,
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
    input  B1;
    input  C1;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Resolve W240 warnings for unused power/ground inputs by adding a dummy read.
    // This wire is purely for linting and will be optimized out by synthesis,
    // preserving the functional behavior of the core logic.
    wire _unused_power_inputs = VPWR | VGND | VPB | VNB;

    // This is an OAI211 cell.
    // Y = !((A1 & A2) | B1 | C1)
    assign Y = !((A1 & A2) | B1 | C1);

endmodule
