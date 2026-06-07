module sub_module (input sub_inout);
  // 'inout sub_inout' was changed to 'input sub_inout' to address 'DirectTopInputToInout-ML'.
  // The dummy wire 'dummy_input_sink' and its assignment, originally added to avoid an empty module warning,
  // are removed to resolve the W528 violation (Variable 'dummy_input_sink' set but not read).
endmodule
