// Definition for the black-boxed standard cell to resolve SpyGlass ErrorAnalyzeBBox
module sky130_fd_sc_hd__o41ai (
    Y   ,
    A1  ,
    A2  ,
    A3  ,
    A4  ,
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
    input  A4;
    input  B1;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // To resolve W240 (Input declared but not read) for power pins,
    // explicitly "read" them into a dummy wire. This wire's logic
    // is not functionally related to output Y and will be optimized away by synthesis.
    wire _unused_power_inputs_read = VPWR | VGND | VPB | VNB;

    // O41AI gate behavior: Y = ~((A1 | A2 | A3 | A4) | B1)
    assign Y = ~((A1 | A2 | A3 | A4) | B1);

endmodule
