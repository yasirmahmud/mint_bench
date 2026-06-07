module synth_5133_attempt7 (
  input wire y_port,
  output wire z_out
);

  // SYNTH_5133: Input port 'y_port' is being continuously driven
  assign y_port = 1'b1; // Direct assignment to an input port

  // This line attempts to read 'y_port' to prevent a 'W240' violation
  // (input declared but not read), as 'y_port' is technically used.
  assign z_out = y_port;

endmodule
