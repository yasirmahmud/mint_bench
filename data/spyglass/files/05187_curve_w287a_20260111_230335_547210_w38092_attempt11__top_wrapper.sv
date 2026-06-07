module top_wrapper (
  input clk,
  output result
);

  wire internal_result_wire;

  // 'missing_source_net' is an implicit wire because it's used without a prior 'wire' or 'reg' declaration.
  // It is never assigned a value anywhere in this module, making it undriven.
  // Connecting it to an input port of an instantiated module will trigger W287a.
  sub_block u_sub_instance (
    .data_in (missing_source_net), // W287a: Input 'data_in' of instance 'u_sub_instance' is undriven.
    .data_out(internal_result_wire)
  );

  assign result = internal_result_wire;

  // Use 'clk' to avoid an unused signal warning.
  wire dummy_use_clk;
  assign dummy_use_clk = clk;

endmodule
