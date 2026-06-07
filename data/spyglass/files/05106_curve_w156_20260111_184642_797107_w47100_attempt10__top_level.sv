module top_level (
  output [3:0] result_0,
  output [3:0] result_1,
  output [3:0] result_2,
  output [3:0] result_3,
  output [3:0] result_4,
  output [3:0] result_5
);

  // Declare 6 wires with reversed LSB:MSB indexing. These will be connected
  // to ports defined with standard MSB:LSB indexing in 'my_processor'.
  wire [0:3] reversed_data_0;
  wire [0:3] reversed_data_1;
  wire [0:3] reversed_data_2;
  wire [0:3] reversed_data_3;
  wire [0:3] reversed_data_4;
  wire [0:3] reversed_data_5;

  // Drive the reversed-indexed wires to avoid unused net warnings.
  // This ensures they have a source.
  assign reversed_data_0 = 4'h1;
  assign reversed_data_1 = 4'h2;
  assign reversed_data_2 = 4'h3;
  assign reversed_data_3 = 4'h4;
  assign reversed_data_4 = 4'h5;
  assign reversed_data_5 = 4'h6;

  // Instantiate the 'my_processor' sub-module 6 times.
  // Each connection of '.input_bus(reversed_data_X)' will trigger a W156 violation.
  // This is because 'input_bus' is declared as [3:0] (MSB to LSB) in 'my_processor',
  // but 'reversed_data_X' is declared as [0:3] (LSB to MSB) in 'top_level',
  // causing a bus connection with reversed indexing.
  my_processor inst_0 ( .input_bus(reversed_data_0), .output_bus(result_0) );
  my_processor inst_1 ( .input_bus(reversed_data_1), .output_bus(result_1) );
  my_processor inst_2 ( .input_bus(reversed_data_2), .output_bus(result_2) );
  my_processor inst_3 ( .input_bus(reversed_data_3), .output_bus(result_3) );
  my_processor inst_4 ( .input_bus(reversed_data_4), .output_bus(result_4) );
  my_processor inst_5 ( .input_bus(reversed_data_5), .output_bus(result_5) );

endmodule
