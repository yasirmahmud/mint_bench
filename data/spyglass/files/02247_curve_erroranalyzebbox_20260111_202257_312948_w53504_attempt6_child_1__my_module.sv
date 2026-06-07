module my_module (
  input logic VGND,
  input logic VNB,
  input logic VPB,
  input logic VPWR
);

  // Instantiating 'sky130_fd_sc_hd__decap_8' without providing its module definition
  // will cause SpyGlass to treat it as a black box and infer its interface,
  // triggering an ErrorAnalyzeBBox violation.
  sky130_fd_sc_hd__decap_8 U_DECAP_INST (
    .VGND(VGND),
    .VNB(VNB),
    .VPB(VPB),
    .VPWR(VPWR)
  );

endmodule
