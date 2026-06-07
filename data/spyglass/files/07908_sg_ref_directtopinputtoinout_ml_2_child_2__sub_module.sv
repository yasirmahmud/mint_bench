module sub_module (input io_port);
  // To resolve 'Design Unit has empty definition' and 'Input declared but not read'
  // A dummy assignment consumes the input without altering functional behavior.
  wire unused_signal_to_sink_input;
  assign unused_signal_to_sink_input = io_port;
 endmodule
