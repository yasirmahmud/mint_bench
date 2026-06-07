module sky130_fd_sc_hd__o41a_2 (
    X   ,
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

    output X   ;
    input  A1  ;
    input  A2  ;
    input  A3  ;
    input  A4  ;
    input  B1  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Dummy assignment to silence W240 warnings for unused power/ground/bulk inputs.
    // These inputs are essential for physical design but do not directly compute the logical output X.
    wire _unused_power_ground_ports;
    assign _unused_power_ground_ports = VPWR | VGND | VPB | VNB;

    assign X = (A1 | A2 | A3 | A4) & B1;

endmodule
