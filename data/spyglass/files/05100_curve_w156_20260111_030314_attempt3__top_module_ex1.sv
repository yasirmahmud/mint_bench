module top_module_ex1 ();

  // Declare six wires with LSB:MSB range (index 0 is MSB, 4 is LSB)
  wire [0:4] source_data_0;
  wire [0:4] source_data_1;
  wire [0:4] source_data_2;
  wire [0:4] source_data_3;
  wire [0:4] source_data_4;
  wire [0:4] source_data_5;

  // Wires for outputs from the sub-modules (standard MSB:LSB)
  wire [4:0] result_0;
  wire [4:0] result_1;
  wire [4:0] result_2;
  wire [4:0] result_3;
  wire [4:0] result_4;
  wire [4:0] result_5;

  // Assign values to 'source_data_X' to ensure they are used and have defined values
  assign source_data_0 = 5'b10101; 
  assign source_data_1 = 5'b01010;
  assign source_data_2 = 5'b11001;
  assign source_data_3 = 5'b00110;
  assign source_data_4 = 5'b10001;
  assign source_data_5 = 5'b01110;

  // Instantiate my_sub_block 6 times.
  // The 'input_data_port' in 'my_sub_block' is declared as [4:0] (MSB:LSB).
  // The connecting nets 'source_data_X' are declared as [0:4] (LSB:MSB).
  // When 'source_data_X' (entire bus [0:4]) is connected to 'input_data_port' (entire bus [4:0]),
  // Verilog connects by index: input_data_port[0] gets source_data_X[0], input_data_port[1] gets source_data_X[1], etc.
  // This results in: input_data_port[4] (MSB of port) <== source_data_X[4] (LSB of net)
  //                  input_data_port[0] (LSB of port) <== source_data_X[0] (MSB of net)
  // This constitutes a reversed bus connection, triggering W156 for each instance.
  my_sub_block inst_0 (
    .input_data_port (source_data_0), // W156 violation for input_data_port
    .output_data_port(result_0)
  );

  my_sub_block inst_1 (
    .input_data_port (source_data_1), // W156 violation for input_data_port
    .output_data_port(result_1)
  );

  my_sub_block inst_2 (
    .input_data_port (source_data_2), // W156 violation for input_data_port
    .output_data_port(result_2)
  );

  my_sub_block inst_3 (
    .input_data_port (source_data_3), // W156 violation for input_data_port
    .output_data_port(result_3)
  );

  my_sub_block inst_4 (
    .input_data_port (source_data_4), // W156 violation for input_data_port
    .output_data_port(result_4)
  );

  my_sub_block inst_5 (
    .input_data_port (source_data_5), // W156 violation for input_data_port
    .output_data_port(result_5)
  );

  // Use the outputs to avoid unused signal warnings
  wire [4:0] combined_result = result_0 ^ result_1 ^ result_2 ^ result_3 ^ result_4 ^ result_5;
  // To avoid unused signal warnings for 'combined_result', it can be connected to a top-level output
  // For this example, ensuring it's driven is sufficient for tool usage analysis.

endmodule
