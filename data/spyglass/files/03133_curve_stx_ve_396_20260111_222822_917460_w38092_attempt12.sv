module curve_stx_ve_396_20260111_222822_917460_w38092_attempt12 (
  output reg status_flag
);

  // Declare an event variable. Events are a Verilog simulation construct
  // and are not synthesizable when used in sensitivity lists for always blocks.
  event my_custom_event;

  // STX_VE_396 violation: Invalid reference to event 'my_custom_event'.
  // Using an 'event' type variable in a negedge sensitivity list
  // of an 'always' block is a common way to trigger this rule as it's a
  // simulation-only construct and not synthesizable.
  always @(negedge my_custom_event) begin
    status_flag <= 1'b0; // Assign to an output register to avoid potential 'set but not read' warnings (W528)
  end

endmodule
