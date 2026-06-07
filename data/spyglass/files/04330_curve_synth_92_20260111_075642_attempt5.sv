module curve_synth_92_20260111_075642_attempt5 (
  input wire in_data,
  output wire out_data
);

  assign out_data = in_data;

  specify
    (in_data => out_data) = 1; // SYNTH_92: Specify block may not be supported by all synthesis tools
  endspecify

endmodule
