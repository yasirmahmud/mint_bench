// Parent module that instantiates child_module with extra port connections
// These extra connections do not exist in 'child_module' and will trigger STX_VE_690.
// Two such connections are provided to meet the "Total occurrences (from summary): 2" requirement
// while keeping a single instance violation report.
module curve_stx_ve_690_20260111_175301_438258_w47100_attempt7 (
  input parent_in,
  output parent_out
);

  wire intermediate_wire;

  child_module u_child (
    .in_data(parent_in),
    .out_data(intermediate_wire),
    .extra_port_a(1'b0),          // Extra connection #1 (does not exist in child_module)
    .extra_port_b(intermediate_wire) // Extra connection #2 (does not exist in child_module)
  );

  assign parent_out = intermediate_wire;

endmodule
