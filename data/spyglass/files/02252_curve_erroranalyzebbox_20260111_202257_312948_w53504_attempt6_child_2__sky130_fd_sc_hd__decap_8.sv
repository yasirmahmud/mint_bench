// Dummy module definition to resolve SpyGlass ErrorAnalyzeBBox and W240 violations.
// Decoupling capacitors (decap cells) are typically physical cells that provide
// power integrity without functional logic in RTL. This definition allows SpyGlass
// to analyze the design without inferring a black box for this cell, and by consuming
// its inputs, resolves 'input declared but not read' warnings.
module sky130_fd_sc_hd__decap_8 (
  input VGND,
  input VNB,
  input VPB,
  input VPWR
);
  // No functional logic is needed for a decap cell in RTL.
  // Dummy internal wires to consume the inputs and prevent 'input declared but not read' warnings.
  // This also prevents the module from being considered an "empty definition".
  wire __unused_VGND = VGND;
  wire __unused_VNB = VNB;
  wire __unused_VPB = VPB;
  wire __unused_VPWR = VPWR;
endmodule
