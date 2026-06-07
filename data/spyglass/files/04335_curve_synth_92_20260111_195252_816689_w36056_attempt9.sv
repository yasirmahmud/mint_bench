module curve_synth_92_20260111_195252_816689_w36056_attempt9 (
  input wire clk_in,
  output wire data_out
);

  assign data_out = clk_in;

  specify
    // Pin-to-pin path delay with min:typ:max for both rise and fall transitions
    (clk_in => data_out) = (1:2:3, 4:5:6);
  endspecify

endmodule
