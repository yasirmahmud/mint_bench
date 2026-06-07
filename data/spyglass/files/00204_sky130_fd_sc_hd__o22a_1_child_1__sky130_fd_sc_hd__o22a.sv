// Definition for the instantiated module 'sky130_fd_sc_hd__o22a' to resolve the "no definition" error.
// This implements the logical behavior of an O22A gate: X = (A1 AND A2) OR (B1 AND B2).
module sky130_fd_sc_hd__o22a (
    output X,
    input A1,
    input A2,
    input B1,
    input B2,
    input VPWR,
    input VGND,
    input VPB,
    input VNB
);
    assign X = (A1 & A2) | (B1 & B2);
endmodule
