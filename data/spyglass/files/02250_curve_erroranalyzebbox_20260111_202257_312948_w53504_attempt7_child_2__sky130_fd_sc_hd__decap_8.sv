module sky130_fd_sc_hd__decap_8 (
    input VGND,
    input VNB,
    input VPB,
    input VPWR
);
  // Prevent lint warnings for unused inputs without adding functional logic.
  // decap cells are typically used for power/ground distribution and have no functional logic.
  wire unused_inputs_read;
  assign unused_inputs_read = VGND | VNB | VPB | VPWR;
endmodule
