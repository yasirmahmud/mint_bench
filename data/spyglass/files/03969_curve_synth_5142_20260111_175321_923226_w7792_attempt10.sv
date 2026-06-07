module curve_synth_5142_20260111_175321_923226_w7792_attempt10 (
  input clk,
  input data_in,
  output data_out
);

  reg d_flop;

  // Simple flip-flop to use inputs/outputs
  always @(posedge clk) begin
    d_flop <= data_in;
  end

  assign data_out = d_flop;

  // First specify block: contains a specparam, which is typically ignored by synthesis tools.
  // This should trigger SYNTH_5142.
  specify
    specparam SETUP_TIME_DELAY = 10;
  endspecify

  // Second specify block: contains a module path delay, also typically ignored by synthesis tools.
  // This should trigger another SYNTH_5142.
  specify
    (data_in => data_out) = 5;
  endspecify

endmodule
