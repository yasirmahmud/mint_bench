module debug_init_assign_ex2 (
  output reg [7:0] my_vec
);
  // The original initial block logic:
  //   my_vec = 8'hFF; // 1111_1111
  //   my_vec[3:0] = 4'h0; // 1111_0000
  // This results in my_vec being 8'hF0.
  // This declaration initializes the output register directly for synthesis,
  // resolving SYNTH_5143 (initial block ignored).
  // By making 'my_vec' an output, it is considered 'read' by external modules,
  // resolving W528 (variable set but not read).
  reg [7:0] my_vec = 8'hF0;

endmodule
