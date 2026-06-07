module curve_stx_ve_396_20260111_184323_023959_w53504_attempt10 (
  output reg q_out
);

  // Declaration of an event. Events are simulation-specific constructs
  // and not synthesizable.
  event my_event;

  // According to the provided context examples (Example 1 and 2 for STX_VE_396),
  // referencing an event in an always block's sensitivity list using 'posedge'
  // is considered an "Invalid reference to event" by the STX_VE_396 rule.
  // This construct is valid Verilog-2001 for simulation but non-synthesizable.
  always @(posedge my_event) begin
    q_out <= 1'b1; // Assign to an output register to avoid 'set but not read' warnings (W528)
  end

endmodule
