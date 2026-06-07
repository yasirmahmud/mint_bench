module synth_92_module (
  input wire in_a,
  output wire out_b
);

  assign out_b = in_a;

  specify
    (in_a => out_b) = 10; // SYNTH_92: Specify block may not be supported by synthesis tools
  endspecify

endmodule
