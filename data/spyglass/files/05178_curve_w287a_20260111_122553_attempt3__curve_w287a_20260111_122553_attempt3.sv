module curve_w287a_20260111_122553_attempt3 (
  output wire final_output
);
  // Declare a wire that is not driven by any source.
  // This 'unconnected_signal' will be the cause of the W287a violation.
  wire unconnected_signal;

  // Instantiate 'child_module' using ordered port connection.
  // The first port 'input_data' of u_child is connected to the undriven 'unconnected_signal'.
  // This specific connection is designed to trigger exactly one W287a violation.
  child_module u_child (
    unconnected_signal, // Input 'input_data' of 'u_child' is undriven
    final_output
  );

  // The top-level output 'final_output' is driven by 'u_child.output_result',
  // preventing any unused output warnings for the top module.

endmodule
