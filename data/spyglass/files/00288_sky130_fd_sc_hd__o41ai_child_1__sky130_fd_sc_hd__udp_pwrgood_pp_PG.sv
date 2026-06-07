module sky130_fd_sc_hd__udp_pwrgood_pp$PG (
    OUT,
    IN,
    VPWR,
    VGND
);
    output OUT;
    input  IN;
    input  VPWR;
    input  VGND;

    // Functional model: In a power-good check, the signal typically passes through
    // if power is considered stable/good. For functional simulation, this often
    // simplifies to a buffer. Power integrity inputs (VPWR, VGND) are observed
    // but don't directly modify the data path in this simplified functional model.
    assign OUT = IN;

endmodule
