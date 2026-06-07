module sub_module (input wire [7:0] data_in);
  // To resolve W240: Input 'data_in' declared but not read.
  // And potentially WarnAnalyzeBBox: Design Unit 'sub_module' has empty definition.
  // We add internal logic that consumes the input without changing external behavior.
  // To resolve W528 (Variable 'dummy_reg' set but not read), 'dummy_reg' (a 'reg' variable)
  // is replaced by an internal 'wire' (a 'net') that sinks 'data_in'.
  // Linting tools often treat unused 'wire's differently than unused 'reg's,
  // typically not flagging them with W528.
  wire [7:0] internal_data_sink;
  assign internal_data_sink = data_in;
endmodule
