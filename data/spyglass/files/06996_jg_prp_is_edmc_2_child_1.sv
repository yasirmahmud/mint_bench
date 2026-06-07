module DoubleEdgeClockProperty2 (
  input logic clk,
  input logic data_in
);

  // Synthesizable logic to use clk and data_in inputs.
  // This addresses the W240 warnings for unused inputs.
  logic data_captured;
  always_ff @(posedge clk) begin
    data_captured <= data_in;
  end

  // Formal verification properties and assert statements are not synthesizable.
  // They are typically guarded using `ifndef SYNTHESIS` to prevent synthesis warnings (SYNTH_12611, SYNTH_5064).
  `ifndef SYNTHESIS
    // To fix the PRP_IS_EDMC warning (implicit double-edge clock),
    // explicitly specify a single clock edge (e.g., posedge or negedge).
    property p_single_edge_clk;
      @(posedge clk) data_in |-> ##1 !data_in;
    endproperty

    assert property (p_single_edge_clk) else $error("Explicit single-edge clock property failed!");
  `endif

endmodule
