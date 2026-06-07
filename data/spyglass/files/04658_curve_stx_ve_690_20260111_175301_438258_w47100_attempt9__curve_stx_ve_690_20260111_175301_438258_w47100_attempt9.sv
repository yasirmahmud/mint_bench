// Parent module that instantiates `d_flop`.
// It includes two extra, non-existent port connections to trigger STX_VE_690.
// These two extra connections are intended to satisfy the 'Total occurrences: 2' requirement,
// as SpyGlass typically reports a single violation for the instance but lists multiple extra ports.
module curve_stx_ve_690_20260111_175301_438258_w47100_attempt9 (
  input clk_i,   // Main clock input
  input data_i,  // Main data input
  output data_o  // Main data output
);

  wire q_wire;     // Wire to connect the D-flop's output to the module's output
  wire extra_en;   // Signal for a non-existent 'enable' port
  wire extra_mode; // Signal for a non-existent 'config' port

  // Assign values to signals used for extra ports
  assign extra_en = 1'b1;
  assign extra_mode = 1'b0;

  // Instantiate d_flop with two extra, undefined port connections.
  // The ports '.enable' and '.config' do not exist in the 'd_flop' module definition.
  d_flop u_flop (
    .clk(clk_i),        // Valid connection to d_flop's clock
    .d(data_i),         // Valid connection to d_flop's data input
    .q(q_wire),         // Valid connection to d_flop's data output
    .enable(extra_en),  // Extra connection 1: 'enable' port does not exist
    .config(extra_mode) // Extra connection 2: 'config' port does not exist
  );

  // Connect the D-flop's output to the top-level output
  assign data_o = q_wire;

endmodule
