module top_module_w156_attempt8 (
  output [7:0] final_output_0,
  output [7:0] final_output_1,
  output [7:0] final_output_2,
  output [7:0] final_output_3,
  output [7:0] final_output_4,
  output [7:0] final_output_5
);

  // Wires defined with standard MSB-to-LSB indexing
  wire [7:0] my_bus_0;
  wire [7:0] my_bus_1;
  wire [7:0] my_bus_2;
  wire [7:0] my_bus_3;
  wire [7:0] my_bus_4;
  wire [7:0] my_bus_5;

  // Drive the wires to avoid unused signal warnings
  assign my_bus_0 = 8'hAA;
  assign my_bus_1 = 8'hBB;
  assign my_bus_2 = 8'hCC;
  assign my_bus_3 = 8'hDD;
  assign my_bus_4 = 8'hEE;
  assign my_bus_5 = 8'hFF;

  // Instantiate the sub-module 6 times, each connecting a standard-indexed bus to a reversed-indexed port.
  // Each connection '.data_in(my_bus_X)' will trigger a W156 violation.
  sub_module_w156_attempt8 inst_sub_0 ( .data_in(my_bus_0), .data_out(final_output_0) );
  sub_module_w156_attempt8 inst_sub_1 ( .data_in(my_bus_1), .data_out(final_output_1) );
  sub_module_w156_attempt8 inst_sub_2 ( .data_in(my_bus_2), .data_out(final_output_2) );
  sub_module_w156_attempt8 inst_sub_3 ( .data_in(my_bus_3), .data_out(final_output_3) );
  sub_module_w156_attempt8 inst_sub_4 ( .data_in(my_bus_4), .data_out(final_output_4) );
  sub_module_w156_attempt8 inst_sub_5 ( .data_in(my_bus_5), .data_out(final_output_5) );

endmodule
