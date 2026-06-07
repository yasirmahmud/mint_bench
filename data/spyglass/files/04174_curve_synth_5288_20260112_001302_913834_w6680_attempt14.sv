module curve_synth_5288_20260112_001302_913834_w6680_attempt14 (
  output reg dummy_event_driven_output
);

  // Declare an 'event' variable. This is a Verilog feature for inter-process communication.
  event trigger_synthesis_violation_event;

  // This 'always' block's sensitivity list includes an 'event' variable.
  // This construct is explicitly unsynthesizable and is the sole trigger for SYNTH_5288.
  always @(trigger_synthesis_violation_event) begin
    // An assignment inside the block to ensure the output is considered "used"
    // and to avoid other potential warnings (e.g., empty always block or unused output).
    // The logic itself is trivial and not meant for synthesis in this context.
    dummy_event_driven_output <= ~dummy_event_driven_output;
  end

  // No other logic is included to ensure that only the SYNTH_5288 rule is violated.
  // The output 'dummy_event_driven_output' is only driven by the unsynthesizable block.

endmodule
