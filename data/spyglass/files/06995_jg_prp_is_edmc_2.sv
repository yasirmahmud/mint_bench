module DoubleEdgeClockProperty2 (
  input logic clk,
  input logic data_in
);

  // For a bit/logic type, '@(clk)' is equivalent to '@(edge clk)',
  // implicitly creating a double-edge clock, triggering the warning.
  property p_double_edge_clk_implicit;
    @(clk) data_in |-> ##1 !data_in;
  endproperty

  assert property (p_double_edge_clk_implicit) else $error("Implicit double edge clock property failed!");

endmodule
