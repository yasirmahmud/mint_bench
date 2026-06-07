module curve_synth_12610_20260112_000335_117075_w47152_attempt13 (
  input wire clk,
  input wire reset_n,
  input wire start_signal,
  input wire end_signal
);

  // SYNTH_12610: Sequence blocks will be ignored for synthesis due to large delay range.
  // The delay range [1:2000] is deliberately large to trigger this warning.
  sequence s_long_delay_monitor;
    @(posedge clk) start_signal ##[1:2000] end_signal;
  endsequence

  // To ensure the sequence is not optimized away if unused,
  // a simple property based on it is included.
  // This property itself is not expected to cause other violations.
  property p_check_long_delay;
    @(posedge clk) disable iff (!reset_n) s_long_delay_monitor;
  endproperty

  // An always block just to ensure input signals are 'used' if synthesis tool requires it.
  // This block does not produce any meaningful logic or latches.
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      // No actual logic, just referencing inputs
    end else begin
      if (start_signal) begin
        // No actual logic
      end
      if (end_signal) begin
        // No actual logic
      end
    end
  end

endmodule
