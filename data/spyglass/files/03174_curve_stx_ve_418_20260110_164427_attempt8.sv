module curve_stx_ve_418_20260110_164427_attempt8 (
  input in_port
);

  // STX_VE_418 violation:
  // The signal 'in_port' is an input port to the module.
  // Input ports are not considered "driven by a gate output" within the module's scope,
  // thus triggering STX_VE_418 for any path where they appear as a source or destination.
  // In this case, both the source and destination of the path are 'in_port'.
  specify
    (in_port => in_port) = 1;
  endspecify

endmodule
