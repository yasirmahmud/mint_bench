module bbox_instance_checker_v10 (
  input wire control_signal,
  output wire status_indicator
);

  // Instantiating 'sky130_fd_sc_hd__fill_2' without its definition
  // will cause SpyGlass to treat it as a black box and infer its interface,
  // triggering an ErrorAnalyzeBBox violation.
  sky130_fd_sc_hd__fill_2 u_filler_cell (
    .VGND(1'b0),
    .VNB(1'b0),
    .VPB(1'b1),
    .VPWR(1'b1)
  );

  // Simple logic to use the input and drive the output,
  // avoiding unused signal warnings.
  assign status_indicator = control_signal;

endmodule
