module curve_synth_92_20260111_195252_816689_w36056_attempt7 (
  input wire in_data,
  output wire out_data
);

  assign out_data = in_data;

  // SYNTH_92: Some synthesis tools might not support specify block
  specify
    (in_data => out_data) = (1:2:3); // Path delay with min:typ:max values
  endspecify

endmodule
