module curve_wrn_1452_20260110_213245_attempt2(my_port_a, my_port_b);

  // First violation: my_port_a
  output [5:0] my_port_a;      // Port declaration with a range [5:0]
  wire [2:0] my_port_a;        // Internal wire declaration with a different range [2:0]

  // Second violation: my_port_b - using LSB:MSB order for external declaration
  output [0:7] my_port_b;      // Port declaration with a range [0:7]
  wire [3:0] my_port_b;        // Internal wire declaration with a different range [3:0]

  // Drive the internally declared wires to prevent unused signal warnings.
  // The assignment width matches the internal wire declaration width to avoid width mismatch warnings.
  assign my_port_a = 3'h2;
  assign my_port_b = 4'hC;

endmodule
