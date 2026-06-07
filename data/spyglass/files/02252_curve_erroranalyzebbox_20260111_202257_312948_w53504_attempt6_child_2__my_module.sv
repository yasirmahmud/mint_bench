module my_module (
  input logic VGND,
  input logic VNB,
  input logic VPB,
  input logic VPWR
);

  sky130_fd_sc_hd__decap_8 U_DECAP_INST (
    .VGND(VGND),
    .VNB(VNB),
    .VPB(VPB),
    .VPWR(VPWR)
  );

endmodule
