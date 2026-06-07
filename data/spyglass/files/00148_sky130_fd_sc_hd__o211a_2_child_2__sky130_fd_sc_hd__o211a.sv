module sky130_fd_sc_hd__o211a (
    X,
    A1,
    A2,
    B1,
    C1,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output X;
    input  A1;
    input  A2;
    input  B1;
    input  C1;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;
    // Functional logic for the o211a standard cell, as it represents (A1 & A2) | B1 | C1
    assign X = (A1 & A2) | B1 | C1;

    // To resolve W240 violations for power and ground inputs which are not
    // functionally 'read' in the Verilog model but are crucial for physical design,
    // dummy assignments are used. These do not affect the functional behavior.
    wire _dummy_VPWR = VPWR;
    wire _dummy_VGND = VGND;
    wire _dummy_VPB   = VPB;
    wire _dummy_VNB   = VNB;

endmodule
