// Dummy module definition to resolve SpyGlass ErrorAnalyzeBBox violation.
// Decoupling capacitors (decap cells) are typically physical cells that provide
// power integrity without functional logic in RTL. This definition allows SpyGlass
// to analyze the design without inferring a black box for this cell.
module sky130_fd_sc_hd__decap_8 (
  input VGND,
  input VNB,
  input VPB,
  input VPWR
);
  // No functional logic is needed for a decap cell in RTL.
endmodule
