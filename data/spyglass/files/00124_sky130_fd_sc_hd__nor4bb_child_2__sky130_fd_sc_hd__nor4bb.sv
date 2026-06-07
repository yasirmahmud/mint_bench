module sky130_fd_sc_hd__nor4bb (
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

    output Y;
    input  A;
    input  B;
    input  C_N;
    input  D_N;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // This module implements a four-input NOR gate where C_N and D_N are
    // considered to be pre-inverted inputs (active-low).
    // The logic is Y = ~(A | B | C_N | D_N).
    assign Y = ~(A | B | C_N | D_N);

    // SpyGlass W240: Inputs VPWR, VGND, VPB, VNB declared but not read.
    // These pins are for power/ground/substrate connectivity and do not
    // affect the logical behavior of the cell. Adding a dummy assignment
    // to satisfy the linter and preserve physical intent.
    wire _unused_power_pins = VPWR | VGND | VPB | VNB;

endmodule
