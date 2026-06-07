module curve_w287a_20260111_122553_attempt5 (
  output top_level_output
);
  // 'undriven_implicit_net' is used as an input to the instance 'u_sub_inst'
  // but is not explicitly declared (e.g., with 'wire', 'reg').
  // In Verilog-2001, this causes it to be implicitly declared as a 'wire'.
  // Since no source drives 'undriven_implicit_net', it remains undriven.
  // Connecting this undriven implicit net to an instance input 'data_in'
  // specifically triggers the W287a violation.
  my_sub_module u_sub_inst (
    .data_in  (undriven_implicit_net), // W287a: Input 'data_in' of instance 'u_sub_inst' is undriven.
    .data_out (top_level_output)
  );

  // All other signals are either properly driven or used to prevent additional violations.
  // 'top_level_output' is driven by 'u_sub_inst'.

endmodule
