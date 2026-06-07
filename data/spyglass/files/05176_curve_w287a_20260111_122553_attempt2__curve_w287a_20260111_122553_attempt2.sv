module curve_w287a_20260111_122553_attempt2 (
  output wire top_level_output
);
  // Declare a wire that is explicitly not driven by any source.
  // This 'undriven_net' will be the cause of the W287a violation.
  wire undriven_net;

  // Instantiate 'sub_module' and connect its input 'in_port_sub'
  // to the undriven 'undriven_net'.
  // This specific connection is designed to trigger exactly one W287a violation.
  sub_module u_sub (
    .in_port_sub (undriven_net),
    .out_port_sub (top_level_output)
  );

  // The top-level output 'top_level_output' is driven by 'u_sub.out_port_sub',
  // preventing any unused output warnings for the top module.

endmodule
