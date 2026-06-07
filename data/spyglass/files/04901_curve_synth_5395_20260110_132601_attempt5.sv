module curve_synth_5395_20260110_132601_attempt5 (
  input clk,
  input rst_n,
  input data_toggle, // A non-clock, non-reset, edge-sensitive signal
  input d_in,
  output reg q_out
);

  // SYNTH_5395: Improper asynchronous style of modeling. Not synthesizable.
  // This rule is triggered by an always block with more than two distinct edge-sensitive events
  // in its sensitivity list. Here, 'posedge clk' is the primary clock, 'negedge rst_n' is
  // an asynchronous reset, and 'posedge data_toggle' is a third independent edge-sensitive event.
  // This mixed-edge sensitivity for a single sequential element is considered an improper
  // asynchronous style, making the circuit difficult or impossible to synthesize into standard
  // flip-flops which typically have a single clock and optionally one asynchronous set/reset.
  always @(posedge clk or negedge rst_n or posedge data_toggle) begin
    if (!rst_n) begin
      // Asynchronous reset has highest priority
      q_out <= 1'b0;
    end else begin
      // This data update occurs on either posedge clk OR posedge data_toggle,
      // which is the core reason for the SYNTH_5395 violation.
      q_out <= d_in;
    end
  end

endmodule
