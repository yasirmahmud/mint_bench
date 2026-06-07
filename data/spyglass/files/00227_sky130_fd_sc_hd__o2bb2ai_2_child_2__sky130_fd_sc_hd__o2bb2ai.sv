module sky130_fd_sc_hd__o2bb2ai (
    Y,
    A1_N,
    A2_N,
    B1,
    B2,
    VPWR,
    VGND,
    VPB,
    VNB
);
    output Y;
    input  A1_N;
    input  A2_N;
    input  B1;
    input  B2;
    input  VPWR;
    input  VGND;
    input  VPB;
    input  VNB;

    // Functional model added to resolve 'WarnAnalyzeBBox' and 'W240' violations.
    // Based on the 'o2bb2ai' naming convention, this implements an OR2-AND2-INVERTER (OAI22)
    // where A1_N and A2_N are inputs to the OR gate, B1 and B2 are inputs to the AND gate.
    assign Y = ~((A1_N | A2_N) & (B1 & B2));

endmodule
