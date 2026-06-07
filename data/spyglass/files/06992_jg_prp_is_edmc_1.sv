module DoubleEdgeClockProperty1 (
  input logic clk,
  input logic enable
);

  // This property explicitly uses 'edge clk', triggering the double-edge clock warning.
  property p_double_edge_clk_explicit;
    @(edge clk) enable |-> ##1 !enable;
  endproperty

  assert property (p_double_edge_clk_explicit) else $error("Double edge clock property failed!");

endmodule
