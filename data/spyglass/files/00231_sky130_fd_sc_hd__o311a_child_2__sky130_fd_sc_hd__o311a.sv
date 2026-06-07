// Definition for sky130_fd_sc_hd__o311a to resolve SpyGlass black-box violation
// This implements the standard combinational logic for an o311a gate.
module sky130_fd_sc_hd__o311a (
    X   ,
    A1  ,
    A2  ,
    A3  ,
    B1  ,
    C1  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output X;
    input  A1;
    input  A2;
    input  A3;
    input  B1;
    input  C1;
    input  VPWR; // Power input, not used in logical calculation
    input  VGND; // Ground input, not used in logical calculation
    input  VPB ; // Bulk power, not used in logical calculation
    input  VNB ; // Bulk ground, not used in logical calculation

    // Implement the OR logic: X = A1 | A2 | A3 | B1 | C1
    assign X = A1 | A2 | A3 | B1 | C1;

    // Dummy assignments to suppress 'declared but not read' warnings for power/ground pins.
    // These assignments do not affect the functional logic of the gate.
    wire _sg_unused_VPWR = VPWR;
    wire _sg_unused_VGND = VGND;
    wire _sg_unused_VPB  = VPB;
    wire _sg_unused_VNB  = VNB;

endmodule
