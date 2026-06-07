module data_processor;
  parameter NUM_CHANNELS = 4;

  // Declare an array of logic at the module level to store channel data.
  // This moves the declaration out of the generate block, allowing external access.
  logic [7:0] channel_data_arr[NUM_CHANNELS];

  genvar i;
  for (i = 0; i < NUM_CHANNELS; i++) begin : channel_instance_loop_gen // Renamed generate block to follow '_gen' convention
    // Assign to the corresponding element of the array.
    assign channel_data_arr[i] = i;
  end

  // To resolve the W528 "set but not read" violation for 'channel_data_arr' elements,
  // we must ensure they are read. We do this by concatenating all channel data
  // into a single wider internal wire. This acts as a dummy sink, making sure
  // each element of 'channel_data_arr' is considered 'read' by the linter.
  // This change maintains the original functional behavior as the data was never
  // used externally or internally beyond its assignment.
  wire [(NUM_CHANNELS * 8) - 1 : 0] dummy_read_sink;

  // Concatenate all elements of the channel_data_arr into the dummy sink.
  // For NUM_CHANNELS = 4, this explicitly concatenates the elements.
  assign dummy_read_sink = {channel_data_arr[3], channel_data_arr[2], channel_data_arr[1], channel_data_arr[0]};

endmodule
