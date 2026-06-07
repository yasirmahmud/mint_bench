module curve_warnanalyzebbox (
  input clk,
  input rst_n,
  input [7:0] data_in,
  output [7:0] data_out
);
  // This module defines an interface.
  // It has been updated to include minimal combinational logic to
  // resolve SpyGlass W240 violations for unused inputs.
  // The functional behavior is a direct pass-through of data_in to data_out,
  // making it behave as a simple buffer or placeholder "black box" from a data path perspective.
  // Clock and reset inputs are consumed by dummy assignments to satisfy linting rules.

  // Assign data_in to data_out to use data_in and provide a default output
  assign data_out = data_in;

  // Create dummy wires to consume unused inputs clk and rst_n, resolving W240 violations
  wire _unused_clk = clk;
  wire _unused_rst_n = rst_n;

endmodule
