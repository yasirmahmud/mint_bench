module curve_synth_5142_20260111_220424_889149_w28836_attempt11 (
  input wire clk,
  input wire data_in,
  output reg data_out
);

  always @(posedge clk) begin
    data_out <= data_in;
  end

  // This specify block contains a $hold timing check, which is only relevant for simulation
  // and will be ignored by synthesis tools, triggering the first SYNTH_5142 violation.
  specify
    $hold(posedge clk, data_in, 5); // $hold(reference_event, data_event, limit)
  endspecify

  // This second specify block contains a simple module path delay, which is also ignored
  // by synthesis tools, triggering the second SYNTH_5142 violation.
  specify
    (data_in => data_out) = 1; // Simple path delay, simulation specific.
  endspecify

endmodule
