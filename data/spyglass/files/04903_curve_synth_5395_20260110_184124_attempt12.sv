module curve_synth_5395_20260110_184124_attempt12 (
  input clk,
  input data_in,
  input trigger_event_sig, // A non-clock, non-reset signal used in sensitivity list
  output reg data_out
);

  // SYNTH_5395: Improper asynchronous style of modeling. Not synthesizable.
  // This 'always' block is sensitive to the positive edge of the clock 'clk' 
  // AND the positive edge of 'trigger_event_sig', which is a data-like signal.
  // Using the edge of a data signal alongside a clock in a sequential 'always' block
  // violates synchronous design principles and is typically not synthesizable to 
  // standard flip-flops, as it represents an improper asynchronous style of modeling
  // or multiple clock domains incorrectly handled in a single block.
  always @(posedge clk or posedge trigger_event_sig) begin
    data_out <= data_in;
  end

endmodule
