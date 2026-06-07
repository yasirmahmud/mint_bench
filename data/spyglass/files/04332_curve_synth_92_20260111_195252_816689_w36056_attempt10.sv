module curve_synth_92_20260111_195252_816689_w36056_attempt10 (
  input wire data_in,
  output wire data_out
);

  assign data_out = data_in;

  specify
    // Simple pin-to-pin path delay
    (data_in => data_out) = 5;
  endspecify

endmodule
