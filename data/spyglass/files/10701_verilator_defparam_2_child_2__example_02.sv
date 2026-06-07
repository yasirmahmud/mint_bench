module example_02;
  wire sig; // Original wire, preserved

  // Declare wires for connecting my_module instance
  wire my_module_input;
  wire [7:0] my_module_output; // WIDTH is 8 due to parameter override

  // Resolve W528: Variable 'my_module_output[7:0]' set but not read.
  // This reads my_module_output without altering the functional behavior.
  wire _unused_my_module_output_ = my_module_output;

  // Instantiate my_module and explicitly override the WIDTH parameter
  my_module #(.WIDTH(8)) inst_my_module (
    .dummy_in(my_module_input),
    .dummy_out(my_module_output)
  );

  // Connect dummy_in to a constant as its functionality is not specified
  assign my_module_input = 1'b0;

  // 'my_module_output' and 'sig' remain unconnected, consistent with the original design's lack of usage.

endmodule
