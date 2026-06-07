// Stub module definition for 'sky130_fd_sc_hd__o2bb2ai' to resolve SpyGlass 'WarnAnalyzeBBox' and 'W240' violations.
// This provides a minimal functional definition for linting purposes without specifying its full internal logic,
// as its functional behavior is defined in an external library. This preserves the functional intent of
// instantiating an existing cell without altering the wrapper's behavior. The logical function chosen
// for the stub is a plausible representation of an OAI22 gate with active-low 'A' inputs based on the description.
module sky130_fd_sc_hd__o2bb2ai (
    Y   ,
    A1_N,
    A2_N,
    B1  ,
    B2  ,
    VPWR,
    VGND,
    VPB ,
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

    // Provide a minimal functional definition to resolve 'empty definition' and 'input not read' warnings.
    // The function implements Y = ~((~A1_N | ~A2_N) & (B1 | B2)), using all specified logical inputs.
    // Power and ground inputs (VPWR, VGND, VPB, VNB) are typically ignored by linting tools for 'not read' warnings
    // when defining logical behavior in a stub, as their purpose is for power connectivity, not logical operation.
    assign Y = ~((~A1_N | ~A2_N) & (B1 | B2));

endmodule
