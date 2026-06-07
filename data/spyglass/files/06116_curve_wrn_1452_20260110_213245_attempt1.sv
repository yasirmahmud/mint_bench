module curve_wrn_1452_20260110_213245_attempt1(my_port_a, my_port_b);

  // First violation: my_port_a
  output [7:0] my_port_a;
  wire [3:0] my_port_a; // Inconsistent range with the output declaration

  // Second violation: my_port_b
  output [2:0] my_port_b;
  wire [1:0] my_port_b; // Inconsistent range with the output declaration

  // Drive the ports to avoid unused signal warnings. The assignment width matches
  // the internal wire declaration, as per context examples to prevent other rule triggers.
  assign my_port_a = 4'hA;
  assign my_port_b = 2'h1;

endmodule
