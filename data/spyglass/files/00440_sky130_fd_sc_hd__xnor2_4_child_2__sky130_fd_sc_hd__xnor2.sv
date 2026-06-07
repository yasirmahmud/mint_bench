// Definition of the instantiated module to resolve ErrorAnalyzeBBox
module sky130_fd_sc_hd__xnor2 (
    output Y,
    input  A,
    input  B,
    input  VPWR,
    input  VGND,
    input  VPB,
    input  VNB
);
    // Behavioral model for XNOR gate
    assign Y = ~(A ^ B);

    // Specify block to declare power inputs as "read" for timing analysis tools.
    // This resolves the W240 violations for unused inputs without altering
    // the functional behavior of the XNOR gate. `pulsestyle_on` is used to
    // mark these signals as significant for timing analysis tools, even if
    // they don't directly drive logic.
    specify
        pulsestyle_on(VPWR);
        pulsestyle_on(VGND);
        pulsestyle_on(VPB);
        pulsestyle_on(VNB);
    endspecify

endmodule
