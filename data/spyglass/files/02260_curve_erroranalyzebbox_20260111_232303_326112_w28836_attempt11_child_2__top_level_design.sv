module top_level_design (
    // No specific inputs/outputs needed for this example,
    // keeping it minimal to avoid other violations.
);

  wire vgnd_wire;
  wire vpwr_wire;
  wire vnb_wire; // For bulk/well connection

  // Assign constant values to avoid implicit nets and ensure usage
  assign vgnd_wire = 1'b0; // Connect to ground
  assign vpwr_wire = 1'b1; // Connect to power
  assign vnb_wire  = 1'b0; // Connect bulk to ground for nmos

  // Instantiating a module 'sky130_fd_sc_hd__decap_8' which is now defined
  // with a non-empty body that satisfies linting.
  sky130_fd_sc_hd__decap_8 i_decap_bb (
    .VGND(vgnd_wire),
    .VPWR(vpwr_wire),
    .VNB(vnb_wire)
  );

endmodule
