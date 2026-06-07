module top_module_ex1 (
  output wire [4:0] final_result // Added output to resolve W528
);

  // Declare six wires with standard MSB:LSB range (index 4 is MSB, 0 is LSB)
  // Changed from [0:4] to [4:0] to resolve W156 violations by matching port declaration
  wire [4:0] source_data_0;
  wire [4:0] source_data_1;
  wire [4:0] source_data_2;
  wire [4:0] source_data_3;
  wire [4:0] source_data_4;
  wire [4:0] source_data_5;

  // Wires for outputs from the sub-modules (standard MSB:LSB)
  wire [4:0] result_0;
  wire [4:0] result_1;
  wire [4:0] result_2;
  wire [4:0] result_3;
  wire [4:0] result_4;
  wire [4:0] result_5;

  // Assign values to 'source_data_X' to ensure they are used and have defined values
  // The bit assignments 5'b... are naturally MSB-first, so changing the wire declaration to [4:0]
  // correctly aligns the bits without needing to reverse the assignment values.
  assign source_data_0 = 5'b10101; 
  assign source_data_1 = 5'b01010;
  assign source_data_2 = 5'b11001;
  assign source_data_3 = 5'b00110;
  assign source_data_4 = 5'b10001;
  assign source_data_5 = 5'b01110;

  // Instantiate my_sub_block 6 times.
  // By declaring 'source_data_X' as [4:0], the connection now matches the port's MSB:LSB order,
  // resolving the W156 violations.
  my_sub_block inst_0 (
    .input_data_port (source_data_0),
    .output_data_port(result_0)
  );

  my_sub_block inst_1 (
    .input_data_port (source_data_1),
    .output_data_port(result_1)
  );

  my_sub_block inst_2 (
    .input_data_port (source_data_2),
    .output_data_port(result_2)
  );

  my_sub_block inst_3 (
    .input_data_port (source_data_3),
    .output_data_port(result_3)
 ;

  my_sub_block inst_4 (
    .input_data_port (source_data_4),
    .output_data_port(result_4)
  );

  my_sub_block inst_5 (
    .input_data_port (source_data_5),
    .output_data_port(result_5)
  );

  // Use the outputs to avoid unused signal warnings
  wire [4:0] combined_result = result_0 ^ result_1 ^ result_2 ^ result_3 ^ result_4 ^ result_5;
  // Connect combined_result to the new top-level output to resolve W528.
  assign final_result = combined_result;

endmodule
