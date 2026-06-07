module curve_synth_92_20260111_195252_816689_w36056_attempt8 (
  input wire in_sig,
  output wire out_sig
);

  assign out_sig = in_sig;

  specify
    (in_sig => out_sig) = (5, 7); // Path delay with separate rise and fall delays
  endspecify

endmodule
