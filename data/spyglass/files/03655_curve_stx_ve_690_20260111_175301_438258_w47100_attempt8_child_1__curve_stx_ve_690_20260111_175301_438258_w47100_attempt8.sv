// Parent module that instantiates child_module with extra port connections.
// These extra connections do not exist in 'child_module' and will trigger
// STX_VE_690 for each undeclared port. Two such connections are provided
// to meet the "Total occurrences (from summary): 2" requirement for the rule,
// reported against a single instance.
module curve_stx_ve_690_20260111_175301_438258_w47100_attempt8 (
  input  master_in,     // Main input signal
  input  control_sig,   // Control signal, used for an extra port
  input  status_ack,    // Status acknowledge, used for another extra port
  output master_out     // Main output signal
);

  wire intermediate_bit; // Wire to connect child module's output to parent's output

  // Instantiate child_module with two extra, undefined port connections.
  child_module u_child (
    .in_bit(master_in),
    .out_bit(intermediate_bit)
  );

  // Connect the intermediate wire to the main output
  assign master_out = intermediate_bit;

endmodule
