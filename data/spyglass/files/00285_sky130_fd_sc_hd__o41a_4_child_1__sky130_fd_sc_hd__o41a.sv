// To resolve the 'Design Unit has no definition' error for 'sky130_fd_sc_hd__o41a',
// a placeholder module definition is provided. In a full design environment,
// this definition would typically be part of a standard cell library.
module sky130_fd_sc_hd__o41a (
    output X,
    input A1,
    input A2,
    input A3,
    input A4,
    input B1,
    input VPWR,
    input VGND,
    input VPB,
    input VNB
);
    // Implement the O41A gate logic: X = (A1 | A2 | A3 | A4) & B1
    assign X = (A1 | A2 | A3 | A4) & B1;
endmodule
