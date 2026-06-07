module sky130_fd_sc_hd__or3 (
    X   ,
    A   ,
    B   ,
    C   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output X   ;
    input  A   ;
    input  B   ;
    input  C   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    assign X = A | B | C;

    // Fix for W240 violations: Power/ground pins are declared as inputs
    // but are not explicitly "read" by the logical assignment in this module.
    // A dummy wire is used to make them appear as read, satisfying the linter
    // without affecting the functional logic of the OR gate.
    wire [3:0] _unused_power_pins_read; // Declaring a dummy wire to 'read' the power inputs
    assign _unused_power_pins_read = {VPWR, VGND, VPB, VNB};

endmodule
