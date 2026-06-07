module curve_stx_ve_396_20260111_222822_917460_w38092_attempt11 (
  output reg data_out
);

  // Declare an event variable. Events are a Verilog simulation construct
  // and are not synthesizable when used in sensitivity lists for always blocks.
  event my_trigger_event;

  // STX_VE_396 violation: Invalid reference to event 'my_trigger_event'.
  // Using an 'event' type variable in a posedge or negedge sensitivity list
  // of an 'always' block is a common way to trigger this rule as it's a
  // simulation-only construct and not synthesizable.
  always @(posedge my_trigger_event) begin
    data_out <= 1'b1; // Assign to an output register to avoid potential 'set but not read' warnings (W528)
  end

endmodule
