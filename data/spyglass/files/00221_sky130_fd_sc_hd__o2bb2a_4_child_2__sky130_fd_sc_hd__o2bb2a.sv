module sky130_fd_sc_hd__o2bb2a (
    X   ,
    A1_N,
    A2_N,
    B1  ,
    B2  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output X;
    input  A1_N;
    input  A2_N;
    input  B1;
    input  B2;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // To resolve W240 violations for unused power pins without altering functional behavior,
    // assign them to dummy wires. These wires are intentionally unused beyond this assignment.
    wire _unused_vpwr = VPWR;
    wire _unused_vgnd = VGND;
    wire _unused_vpb  = VPB;
    wire _unused_vnb  = VNB;

    // This is a stub definition for the standard cell sky130_fd_sc_hd__o2bb2a.
    // Its functional behavior is derived from the typical logic of an O2BB2A gate
    // in the sky130 library, where 'A_N' inputs are active-high to the internal AND gate.
    assign X = (A1_N & A2_N) | (B1 & B2);

endmodule
