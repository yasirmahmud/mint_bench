module curve_stx_ve_418_20260110_164427_attempt12 (
  input  p_in,
  output out_data
);

  // STX_VE_418 violation: 'p_in' is an input port.
  // An input port is driven externally, not by a gate output *within this module*.
  // SpyGlass's STX_VE_418 rule (Path is not valid, because it is not driven by a gate output)
  // is triggered here because 'p_in' is used as the source of a timing path
  // in the specify block, but it lacks an internal gate driver.
  specify
    (p_in => p_in) = 1ps; // Self-referential path similar to context example 2.
  endspecify

  // Drive 'out_data' to avoid undriven output warnings.
  // This also ensures 'p_in' is used in functional logic, avoiding 'unused input' warnings.
  assign out_data = p_in;

endmodule
