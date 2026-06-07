module curve_wrn_1452_20260110_213245_attempt3(
  output [0:0] my_port_x,
  input [7:0] my_port_y,
  output output_z
);

  // First violation: my_port_x
  // External port declaration has range [0:0] (single bit, LSB:MSB order)
  // Internal wire declaration has range [2:0] (multi-bit, MSB:LSB order)
  wire [2:0] my_port_x;

  // Second violation: my_port_y
  // External input port declaration has range [7:0]
  // Internal wire declaration has a different range [3:0]
  wire [3:0] my_port_y;

  // Drive the internally declared my_port_x to prevent unused signal warnings.
  // The assignment width matches the internal wire declaration width (3 bits).
  assign my_port_x = 3'h1;

  // Use a bit from the internally declared my_port_y to prevent unused signal warnings.
  // This uses the [3:0] range of the internal wire, which is valid.
  assign output_z = my_port_y[0];

endmodule
