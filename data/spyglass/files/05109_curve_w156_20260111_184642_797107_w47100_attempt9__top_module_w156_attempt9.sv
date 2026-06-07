module top_module_w156_attempt9 (
  output [7:0] final_output_0,
  output [7:0] final_output_1,
  output [7:0] final_output_2,
  output [7:0] final_output_3,
  output [7:0] final_output_4,
  output [7:0] final_output_5
);

  // Wires defined with reversed LSB-to-MSB indexing. Each will be connected to a standard-indexed port.
  wire [0:7] my_reversed_bus_0;
  wire [0:7] my_reversed_bus_1;
  wire [0:7] my_reversed_bus_2;
  wire [0:7] my_reversed_bus_3;
  wire [0:7] my_reversed_bus_4;
  wire [0:7] my_reversed_bus_5;

  // Drive the wires to avoid unused signal warnings
  assign my_reversed_bus_0 = 8'h11;
  assign my_reversed_bus_1 = 8'h22;
  assign my_reversed_bus_2 = 8'h33;
  assign my_reversed_bus_3 = 8'h44;
  assign my_reversed_bus_4 = 8'h55;
  assign my_reversed_bus_5 = 8'h66;

  // Instantiate the sub-module 6 times.
  // Each connection '.data_in(my_reversed_bus_X)' will trigger a W156 violation
  // because the port 'data_in' is defined as [7:0] (MSB:LSB) in the sub_module,
  // but the connected net 'my_reversed_bus_X' is defined as [0:7] (LSB:MSB) in the top_module.
  sub_module_w156_attempt9 inst_sub_0 ( .data_in(my_reversed_bus_0), .data_out(final_output_0) );
  sub_module_w156_attempt9 inst_sub_1 ( .data_in(my_reversed_bus_1), .data_out(final_output_1) );
  sub_module_w156_attempt9 inst_sub_2 ( .data_in(my_reversed_bus_2), .data_out(final_output_2) );
  sub_module_w156_attempt9 inst_sub_3 ( .data_in(my_reversed_bus_3), .data_out(final_output_3) );
  sub_module_w156_attempt9 inst_sub_4 ( .data_in(my_reversed_bus_4), .data_out(final_output_4) );
  sub_module_w156_attempt9 inst_sub_5 ( .data_in(my_reversed_bus_5), .data_out(final_output_5) );

endmodule
