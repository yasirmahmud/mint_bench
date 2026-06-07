module curve_synth_92_20260111_075642_attempt4 (
  input wire input_a,
  output wire output_z
);

  assign output_z = input_a;

  specify
    (input_a => output_z) = 100; // SYNTH_92: Specify block implies delays and may not be supported by synthesis tools
  endspecify

endmodule
