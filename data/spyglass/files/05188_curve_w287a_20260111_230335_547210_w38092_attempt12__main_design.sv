module main_design (
  output module_output
);

  // 'undriven_implicit_connection' is an implicit wire because it's used
  // in the port connection without a prior 'wire' or 'reg' declaration.
  // It is never assigned a value by any source in this module, making it undriven.
  // Connecting this undriven implicit wire to an input port of an instance
  // will trigger the W287a violation.
  sub_module u_sub_instance (
    .sub_input_port(undriven_implicit_connection), // W287a: Input 'sub_input_port' of instance 'u_sub_instance' is undriven.
    .sub_output_port(module_output) // Connect sub-module output to top-level output
  );

  // 'module_output' is driven by 'u_sub_instance.sub_output_port'.
  // All other signals are either inputs to instances (undriven_implicit_connection)
  // or outputs from instances/module, ensuring no unused signals.

endmodule
