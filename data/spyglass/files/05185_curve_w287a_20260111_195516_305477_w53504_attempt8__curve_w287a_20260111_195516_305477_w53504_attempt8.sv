module curve_w287a_20260111_195516_305477_w53504_attempt8 (
  output top_output
);

  // 'implicit_undriven_net' is used here but not explicitly declared as wire/reg.
  // According to Verilog-2001 rules, it defaults to an implicit wire.
  // Since it is never assigned a value anywhere, it remains undriven.
  my_sub_module u_inst (
    .in_port(implicit_undriven_net), // Input 'in_port' of instance 'u_inst' is connected to this undriven implicit wire.
    .out_port(top_output)            // Connect sub-module output to top-level output.
  );

  // No assignment to 'implicit_undriven_net' anywhere in this module.
  // This configuration should trigger W287a exactly once.

endmodule
