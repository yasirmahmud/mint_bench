module curve_wrn_1452_20260110_213245_attempt4(
  my_port_a,
  my_port_b,
  my_output_c
);

  // External port declarations (non-ANSI style)
  output [7:0] my_port_a;
  input  [0:7] my_port_b; // Different range order for variety
  output my_output_c;

  // Internal declaration for 'my_port_a' with an inconsistent range (4 bits vs external 8 bits)
  // This should trigger WRN_1452 for my_port_a.
  wire [3:0] my_port_a;

  // Internal declaration for 'my_port_b' with an inconsistent range (2 bits vs external 8 bits)
  // This should trigger WRN_1452 for my_port_b.
  wire [1:0] my_port_b;

  // Drive the internally declared 'my_port_a' to prevent unused signal warning.
  // This assignment uses the 4-bit range of the internal wire.
  assign my_port_a = 4'hA; // Drives bits [3:0] of the port

  // Use a bit from the internally declared 'my_port_b' to prevent unused signal warning.
  // This reads bit [0] from the 2-bit internal wire.
  assign my_output_c = my_port_b[0];

endmodule
