module curve_synth_5142_20260111_175321_923226_w7792_attempt9 (
  input clk,
  input data_in,
  output data_out
);

  reg d_flop;
  reg setup_notifier; // Used only within the specify block for timing checks

  always @(posedge clk) begin
    d_flop <= data_in;
  end

  assign data_out = d_flop;

  // This specify block contains a simulation-specific timing check ($setup)
  // and is typically ignored by synthesis tools, triggering SYNTH_5142.
  specify
    $setup(data_in, posedge clk, 10, setup_notifier);
  endspecify

endmodule
