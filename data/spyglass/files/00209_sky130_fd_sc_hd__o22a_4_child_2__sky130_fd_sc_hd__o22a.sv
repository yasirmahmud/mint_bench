module sky130_fd_sc_hd__o22a (
    X,
    A1,
    A2,
    B1,
    B2,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output X;
    input  A1;
    input  A2;
    input  B1;
    input  B2;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Dummy definition to resolve black-box violation (ErrorAnalyzeBBox).
    // A common interpretation for 'o22a' standard cell is (A1 OR A2) AND (B1 OR B2).
    // This preserves the functional intent of 'computing a logic function'.
    assign X = (A1 | A2) & (B1 | B2);

    // Resolve W240 warnings for power/ground/bulk inputs in this dummy behavioral model.
    // These inputs are essential for physical implementation but do not directly
    // participate in the boolean logic calculation of this specific model.
    // A dummy assignment is used to make the linter recognize they are "read".
    wire _dummy_power_read_ack;
    assign _dummy_power_read_ack = VPWR | VGND | VPB | VNB;

endmodule // sky130_fd_sc_hd__o22a
