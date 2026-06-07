module synth_5133_example (
  input wire x,
  input wire y
);

  // SYNTH_5133: Input port 'y' is being continuously driven
  assign y = x;

endmodule
