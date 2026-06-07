module curve_synth_5395_20260110_184124_attempt10 (
  input clk,
  input rst_n,
  input trigger_signal,
  input data_in,
  output reg out_reg
);

  // SYNTH_5395: Improper asynchronous style of modeling. Not synthesizable.
  // The sensitivity list includes posedge clk, negedge rst_n, AND posedge trigger_signal.
  // While posedge clk and negedge rst_n (for an asynchronous reset) are a standard
  // synthesizable pattern, the inclusion of posedge trigger_signal (a non-clock/non-reset data signal)
  // as an additional edge event makes the block non-synthesizable by standard tools.
  // This constitutes an "improper asynchronous style of modeling" because a sequential element
  // should only be sensitive to one clock edge and, optionally, one asynchronous reset edge.
  // Including a third independent edge event is a clear violation of synthesizable modeling practices.
  always @(posedge clk or negedge rst_n or posedge trigger_signal) begin
    if (!rst_n) begin // Asynchronous active-low reset
      out_reg <= 1'b0;
    end else begin
      // The logic here is triggered by posedge clk OR posedge trigger_signal (after reset).
      // This dual independent edge sensitivity makes it an improper asynchronous style.
      out_reg <= data_in;
    end
  end

endmodule
