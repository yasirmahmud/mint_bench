module sky130_fd_sc_hd__o32ai (
    Y,
    A1,
    A2,
    A3,
    B1,
    B2,
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
    input  B2;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    wire or3_out;
    wire or2_out;
    wire and_out;

    assign or3_out = A1 | A2 | A3;
    assign or2_out = B1 | B2;
    assign and_out = or3_out & or2_out;
    assign Y = ~and_out; 

endmodule
