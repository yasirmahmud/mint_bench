module curve_wrn_1452_module (
  my_input_port,
  my_output_port
);

  // Declare port directions and widths using traditional Verilog-2001 style.
  input [15:0] my_input_port;
  output [7:0] my_output_port;

  // WRN_1452 Violation:
  // The port 'my_input_port' is initially declared as an input with range [15:0].
  // Its subsequent re-declaration here as an internal wire with an inconsistent range [7:0]
  // triggers exactly one WRN_1452.
  wire [7:0] my_input_port; 

  // Assign a value to the output port using the re-declared internal wire.
  // This prevents unused signal warnings for both 'my_output_port' and the re-declared 'my_input_port'.
  assign my_output_port = my_input_port[7:0]; // Slice 'my_input_port' to match 'my_output_port' width

endmodule
