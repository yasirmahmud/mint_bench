module sky130_fd_sc_hd__sdfstp (
    Q,
    CLK,
    D,
    SCD,
    SCE,
    SET_B,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Q;
    input  CLK;
    input  D;
    input  SCD;
    input  SCE;
    input  SET_B;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;
    // Empty module definition to resolve the 'black-box' error for linting.
    // The actual functional behavior of this base cell is expected to be
    // provided by a separate technology library file, but for the purpose
    // of a self-contained linting run, this declaration makes the module visible.
endmodule
