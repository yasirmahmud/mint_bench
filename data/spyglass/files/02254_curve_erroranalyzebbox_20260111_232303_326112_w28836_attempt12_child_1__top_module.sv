module top_module ();

  // Instantiating a module 'sky130_fd_sc_hd__decap_8' which is not defined
  // within this Verilog file or any included files. This lack of definition
  // will cause SpyGlass to treat 'sky130_fd_sc_hd__decap_8' as a black box
  // and infer its interface based on the instantiated ports (VGND, VPWR, VNB).
  // This behavior directly triggers the ErrorAnalyzeBBox violation.
  sky130_fd_sc_hd__decap_8 u_decap_instance (
    .VGND(1'b0), // Ground connection
    .VPWR(1'b1), // Power connection
    .VNB(1'b0)   // n-well bulk tied to ground
  );

endmodule
