module curve_w287a_20260111_122553_attempt4 (
  input wire top_level_input,
  output wire top_level_output
);
  // Declare a wire that is not driven by any source.
  // This 'undriven_net_for_instance' will cause the W287a violation when connected to an instance input.
  wire undriven_net_for_instance;

  // Declare another wire that is explicitly driven, to connect to other instance inputs 
  // and to use the top-level input.
  wire driven_net;
  assign driven_net = top_level_input;

  // Instantiate 'my_sub_module' using named port connections.
  // Connecting 'data_in_a' of 'u_my_sub' to 'undriven_net_for_instance' 
  // triggers the W287a violation.
  my_sub_module u_my_sub (
    .data_in_a  (undriven_net_for_instance), // W287a: Input 'data_in_a' of instance 'u_my_sub' is undriven.
    .data_in_b  (driven_net),
    .data_out_c (top_level_output)
  );

  // All top-level signals and internal wires are either driven or used as required,
  // preventing other common violations like unused signals or undriven outputs.

endmodule
