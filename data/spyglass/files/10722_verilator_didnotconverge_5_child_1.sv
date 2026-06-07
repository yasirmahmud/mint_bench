module osc5;
  wire a, b;
  assign a = 1'b0; // Drive 'a' to a constant to break the combinational loop and provide a stable source.
  assign b = a;    // 'b' now follows 'a', which is stable, resolving the oscillation.
endmodule
