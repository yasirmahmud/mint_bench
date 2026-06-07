module top_module_ex1 (
  output wire [3:0] top_output
);
  // Declare a wire with LSB:MSB range (index 0 is MSB, 3 is LSB)
  wire [0:3] my_source_bus; 
  wire [3:0] sub_output_from_inst; // Standard MSB:LSB

  // Assign a value to 'my_source_bus' to ensure it is used
  // For example, if my_source_bus = 4'b1011, then:
  // my_source_bus[0] = 1 (MSB)
  // my_source_bus[1] = 0
  // my_source_bus[2] = 1
  // my_source_bus[3] = 1 (LSB)
  assign my_source_bus = 4'b1011; 

  // Instantiate sub_module.
  // The 'data_in' port in 'sub_module' is declared as [3:0] (MSB:LSB).
  // The connecting net 'my_source_bus' is declared as [0:3] (LSB:MSB).
  // When 'my_source_bus' (entire bus [0:3]) is connected to 'data_in' (entire bus [3:0]),
  // Verilog connects by index: data_in[0] gets my_source_bus[0], data_in[1] gets my_source_bus[1], etc.
  // This results in:
  // data_in[3] (MSB of port) <== my_source_bus[3] (LSB of net)
  // data_in[0] (LSB of port) <== my_source_bus[0] (MSB of net)
  // This constitutes a reversed bus connection, triggering W156.
  sub_module u_sub (
    .data_in  (my_source_bus), // Target line for W156: Bus net 'data_in' is connected in reverse.
    .data_out (sub_output_from_inst)
  );

  // Drive the top-level output to ensure 'sub_output_from_inst' is used
  assign top_output = sub_output_from_inst;

endmodule
