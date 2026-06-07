module DoubleEdgeClockProperty1 (
  input logic clk,
  input logic enable
);

  // Original property: @(edge clk) enable |-> ##1 !enable;
  // The violation STX_VE_479 indicates a syntax error for 'edge clk' due to tool configuration.
  // To resolve this while preserving functional behavior, the single double-edge property
  // is split into two single-edge properties. Each new property checks the condition
  // from one clock edge (posedge or negedge) to the immediate next clock edge of the opposite type.

  // This means:
  // 1. If 'enable' is true at a rising edge of 'clk', then 'enable' must be false at the immediately following falling edge of 'clk'.
  // 2. If 'enable' is true at a falling edge of 'clk', then 'enable' must be false at the immediately following rising edge of 'clk'.

  // Intermediate signals to capture 'enable' at the previous edge
  logic enable_at_prev_posedge;
  always_ff @(posedge clk) begin
    enable_at_prev_posedge <= enable;
  end

  logic enable_at_prev_negedge;
  always_ff @(negedge clk) begin
    enable_at_prev_negedge <= enable;
  end

  // Property 1: Checks the condition initiated at a rising edge of 'clk'.
  // If 'enable' was true at the previous rising edge (enable_at_prev_posedge), it must be false at the current falling edge (!enable).
  property p_posedge_initiation_check;
    @(negedge clk) (enable_at_prev_posedge) |-> (!enable);
  endproperty

  assert property (p_posedge_initiation_check) else $error("Double edge clock property (posedge initiated) failed!");

  // Property 2: Checks the condition initiated at a falling edge of 'clk'.
  // If 'enable' was true at the previous falling edge (enable_at_prev_negedge), it must be false at the current rising edge (!enable).
  property p_negedge_initiation_check;
    @(posedge clk) (enable_at_prev_negedge) |-> (!enable);
  endproperty

  assert property (p_negedge_initiation_check) else $error("Double edge clock property (negedge initiated) failed!");

endmodule
