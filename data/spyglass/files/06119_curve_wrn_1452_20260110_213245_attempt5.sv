module curve_wrn_1452_20260110_213245_attempt5(
  output [7:0] my_port_a,
  input  [0:3] my_port_b,
  output       my_output_c
);

  // Internal declaration for 'my_port_a' with an inconsistent range.
  // External declaration (in port list) is [7:0], internal is [3:0].
  // This should trigger WRN_1452 for 'my_port_a'.
  reg [3:0] my_port_a;

  // Internal declaration for 'my_port_b' with an inconsistent range.
  // External declaration (in port list) is [0:3], internal is [7:0].
  // This should trigger WRN_1452 for 'my_port_b'.
  wire [7:0] my_port_b;

  // Drive the internally declared 'my_port_a' to prevent unused signal warnings.
  // The assignment uses the 4-bit width of the internal 'reg'.
  assign my_port_a = 4'hF;

  // Use a bit from the internally declared 'my_port_b' to prevent unused signal warnings.
  // This reads bit [0] from the 8-bit internal 'wire'.
  assign my_output_c = my_port_b[0];

endmodule
