module sub_module_ex2 (input [7:0] in_port);
  // To resolve WarnAnalyzeBBox (empty definition) and W240 (input not read),
  // we add an internal assignment that uses the input port.
  // The input port width is also adjusted from [3:0] to [7:0] to resolve W110
  // (incompatible width) and match the 'my_wire' signal in 'top_module_ex2'.
  wire [7:0] internal_signal_to_use_port;
  assign internal_signal_to_use_port = in_port;
endmodule
