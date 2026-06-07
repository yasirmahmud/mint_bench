module curve_synth_5288_20260110_180940_attempt7 (
  input wire clk,
  input wire rst_n,
  input wire enable,
  output wire out_reg
);

  // Declare an event variable with a distinct name for example #2
  event synth_event_trigger;

  // This always block uses 'synth_event_trigger' in its sensitivity list,
  // which is not synthesizable and triggers SYNTH_5288.
  always @(synth_event_trigger) begin
    $display("SYNTH_5288 triggered by event wait!"); // Distinct message
  end

  // Minimal synthesizable logic to prevent other common warnings
  // (e.g., unused inputs/outputs, latches) in the rest of the design.
  reg internal_data;
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      internal_data <= 1'b0;
    end else begin
      internal_data <= enable; // Uses 'enable' input
    end
  end

  assign out_reg = internal_data; // Drives 'out_reg' output

endmodule
