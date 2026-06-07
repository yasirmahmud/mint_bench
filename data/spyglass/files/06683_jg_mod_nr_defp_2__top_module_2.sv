module top_module_2 (
  input wire enable_in,
  output wire status_out
);
  sub_module_b instance_b (
    .enable(enable_in),
    .status(status_out)
  );

  defparam top_module_2.instance_b.INITIAL_STATE = 1'b1; // This will trigger the warning

endmodule
