module sky130_fd_sc_hd__o21a (
    output X,
    input  A1,
    input  A2,
    input  B1,
    input  VPWR,
    input  VGND,
    input  VPB,
    input  VNB
);
    // Behavioral model to define the standard cell's logic.
    // X = (A1 OR A2) AND B1
    assign X = (A1 | A2) & B1;

endmodule
