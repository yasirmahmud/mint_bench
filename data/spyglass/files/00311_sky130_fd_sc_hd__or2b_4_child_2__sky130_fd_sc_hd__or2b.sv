module sky130_fd_sc_hd__or2b (
    X   ,
    A   ,
    B_N ,
    VPWR,
    VGND,
    VPB ,
    VNB
);
    output X   ;
    input  A   ;
    input  B_N ;
    // spyglass disable_port_read_check W240
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;
    // spyglass enable_port_read_check W240

    // Logical definition of an OR gate with one inverted input (B_N)
    assign X = A | (~B_N);

endmodule // sky130_fd_sc_hd__or2b
