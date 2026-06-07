module curve_synth_5288_20260112_001302_913834_w6680_attempt15 (
  output reg dummy_output
);

  // Declare an 'event' variable. This is a Verilog feature for inter-process communication.
  event synthesis_violation_event;

  // This 'always' block's sensitivity list includes an 'event' variable.
  // According to Verilog synthesis guidelines, a construct sensitive to an 'event'
  // is explicitly unsynthesizable and triggers the SYNTH_5288 violation.
  always @(synthesis_violation_event) begin
    // Assign a constant value to the output. This ensures the output signal is considered 'used'
    // and prevents other warnings like 'unused signal' or 'empty always block'.
    // Crucially, by assigning a constant, we avoid reading any register on the RHS,
    // thereby preventing the W122 violation seen in previous attempts.
    dummy_output <= 1'b0;
  end

  // No other logic is included to ensure that only the SYNTH_5288 rule is violated.
  // The module is minimal and adheres to Verilog-2001 syntax.

endmodule
