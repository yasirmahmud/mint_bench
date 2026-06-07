// Parent module that instantiates `simple_and_gate`.
// It includes two extra, non-existent port connections to trigger STX_VE_690.
// These two extra connections are intended to satisfy the 'Total occurrences: 2'
// requirement, as SpyGlass typically reports a single violation for the instance
// but enumerates multiple extra ports within that violation.
module curve_stx_ve_690_20260111_175301_438258_w47100_attempt10 (
  input signal_a,  // First input to the top-level module
  input signal_b,  // Second input to the top-level module
  output result_o   // Output from the instantiated AND gate
);

  wire and_result;       // Wire to connect the AND gate's output
  wire extra_signal_x;   // Signal for a non-existent 'extra_port_a'
  wire extra_signal_y;   // Signal for a non-existent 'extra_port_b'

  // Assign values to signals used for extra ports
  assign extra_signal_x = 1'b0;
  assign extra_signal_y = 1'b1;

  // Instantiate simple_and_gate with two extra, undefined port connections.
  // The ports '.extra_port_a' and '.extra_port_b' do not exist in the 'simple_and_gate' module definition.
  simple_and_gate u_and_gate (
    .in1(signal_a),            // Valid connection to simple_and_gate's in1
    .in2(signal_b),            // Valid connection to simple_and_gate's in2
    .out_and(and_result),      // Valid connection to simple_and_gate's out_and
    .extra_port_a(extra_signal_x), // Extra connection 1: 'extra_port_a' does not exist
    .extra_port_b(extra_signal_y)  // Extra connection 2: 'extra_port_b' does not exist
  );

  // Connect the AND gate's output to the top-level output
  assign result_o = and_result;

endmodule
