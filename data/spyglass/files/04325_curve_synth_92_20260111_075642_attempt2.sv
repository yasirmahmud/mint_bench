module curve_synth_92_20260111_075642_attempt2 (
  input wire sig_in,
  output wire sig_out
);

  assign sig_out = sig_in;

  specify
    (sig_in => sig_out) = 25; // SYNTH_92: Specify block may not be supported by synthesis tools
  endspecify

endmodule
