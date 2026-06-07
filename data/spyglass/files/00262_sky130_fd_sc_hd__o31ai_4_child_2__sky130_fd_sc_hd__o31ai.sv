module sky130_fd_sc_hd__o31ai (
    Y   ,
    A1  ,
    A2  ,
    A3  ,
    B1  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output Y;
    input  A1;
    input  A2;
    input  A3;
    input  B1;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Fix for SpyGlass W240: "Input declared but not read."
    // These power and ground inputs are essential for physical implementation
    // but are not part of the logical computation in this behavioral model.
    // A dummy assignment ensures they are 'read' by the linter without
    // affecting the functional behavior of the logic gate.
    wire _unused_power_ground_read = VPWR | VGND | VPB | VNB;

    assign Y = ~((A1 | A2 | A3) & B1);

endmodule
