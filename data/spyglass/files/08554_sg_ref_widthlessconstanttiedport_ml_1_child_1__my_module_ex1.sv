module my_module_ex1 (input [0:0] in_port);
  // To resolve W240 (Input 'in_port' declared but not read)
  // and WarnAnalyzeBBox (Design Unit 'my_module_ex1' has empty definition),
  // the input is used internally. Declaring the input with an explicit width
  // also addresses the context of WidthlessConstantTiedPort-ML.
  wire unused_in_port_sink;
  assign unused_in_port_sink = in_port;
endmodule
