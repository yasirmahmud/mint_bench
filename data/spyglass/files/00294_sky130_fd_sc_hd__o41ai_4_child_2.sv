module sky130_fd_sc_hd__o41ai_4 (
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

    output Y   ;
    input  A1  ;
    input  A2  ;
    input  A3  ;
    input  A4  ;
    input  B1  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Dummy assignments to consume power inputs and resolve W240 violations.
    // These assignments do not affect the functional output Y but satisfy linting rules.
    wire _unused_VPWR = VPWR;
    wire _unused_VGND = VGND;
    wire _unused_VPB  = VPB;
    wire _unused_VNB  = VNB;

    assign Y = ~ (B1 && (A1 || A2 || A3 || A4));

endmodule
