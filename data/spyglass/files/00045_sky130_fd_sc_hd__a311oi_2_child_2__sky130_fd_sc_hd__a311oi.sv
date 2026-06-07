module sky130_fd_sc_hd__a311oi (
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

    // Implement the A311OI logic: Y = ~((A1 & A2 & A3) | B1 | C1)
    assign Y = ~((A1 & A2 & A3) | B1 | C1);

    // Dummy assignments to resolve 'input declared but not read' warnings for power pins.
    // These signals are part of the cell's interface for physical connections but are not
    // logically 'read' by the behavioral model. This resolves lint warnings without affecting functionality.
    wire _unused_VPWR_ = VPWR;
    wire _unused_VGND_ = VGND;
    wire _unused_VPB_  = VPB;
    wire _unused_VNB_  = VNB;

endmodule
