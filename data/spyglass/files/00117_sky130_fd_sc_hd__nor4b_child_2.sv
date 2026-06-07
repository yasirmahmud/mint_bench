module sky130_fd_sc_hd__nor4b (
    Y   ,
    A   ,
    B   ,
    C_N ,
    D_N ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    output Y   ;
    input  A   ;
    input  B   ;
    input  C_N ;
    input  D_N ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Functional behavior: Four-input NOR gate with inputs A, B, C_N, D_N.
    // C_N and D_N are considered active-low inputs as per typical _N naming convention,
    // so they are directly used in the NOR function.
    assign Y = !(A | B | C_N | D_N);

    // Suppress linting warnings for unused power/ground inputs (VPWR, VGND, VPB, VNB).
    // These inputs are essential for physical design (power delivery) but are not
    // functionally used in the RTL logic of the NOR gate. Assigning them to a dummy
    // wire makes them 'read' by the linter without affecting the functional behavior.
    wire _unused_power_ports_ = VPWR | VGND | VPB | VNB;

endmodule
