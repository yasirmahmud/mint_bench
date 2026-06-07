module sky130_fd_sc_hd__decap_8 (
    input VGND,
    input VNB,
    input VPB,
    input VPWR
);
  // This is a dummy definition to resolve ErrorAnalyzeBBox violation.
  // decap cells are typically used for power/ground distribution and have no functional logic.
endmodule
