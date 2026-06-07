module data_processor;
  parameter NUM_CHANNELS = 4;

  genvar i;
  for (i = 0; i < NUM_CHANNELS; i++) begin : channel_instance_loop
    // This generate block name 'channel_instance_loop' does not follow a convention like ending in '_gen'.
    logic [7:0] channel_data;
    assign channel_data = i;
  end
endmodule
