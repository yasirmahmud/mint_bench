module curve_synth_5260_20260111_222626_268694_w38092_attempt11();

  // Four parameter string declarations, each triggering SYNTH_5260.
  parameter string PARAM_MSG_1 = "Violation #1: Parameter string.";
  parameter string PARAM_MSG_2 = "Violation #2: Parameter string.";
  parameter string PARAM_MSG_3 = "Violation #3: Parameter string.";
  parameter string PARAM_MSG_4 = "Violation #4: Parameter string.";

  // One local string variable declaration, triggering SYNTH_5260.
  // Declared without initial value to avoid SYNTH_89.
  string local_debug_message; // Violation #5: String variable.

endmodule
