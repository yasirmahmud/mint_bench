module missing_timescale_with_specify (input in_a, output out_b);
  assign out_b = in_a;

  specify
    (in_a => out_b) = 10; // Specify block implies delays without timescale
  endspecify
endmodule
