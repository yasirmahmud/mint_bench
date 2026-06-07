module top_module_7 (
  input  logic some_vnb_signal,
  input  logic some_vpb_signal,
  output logic dummy_out
);

  wire constant_vgnd = 1'b0;
  wire constant_vpwr = 1'b1;

  // Instantiating 'sky130_fd_sc_hd__decap_8' without its definition
  // will cause SpyGlass to treat it as a black box and infer its interface,
  // triggering an ErrorAnalyzeBBox violation.
  sky130_fd_sc_hd__decap_8 i_decap_cell (
    .VGND(constant_vgnd),
    .VNB(some_vnb_signal),
    .VPB(some_vpb_signal),
    .VPWR(constant_vpwr)
  );

  assign dummy_out = 1'b0; // Connect dummy_out to avoid unused output warning

endmodule
