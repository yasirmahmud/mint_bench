module curve_w289_20260111_175845_743545_w53504_attempt7 (
  input real my_real_value
);

  // W289: A real_var operand ('my_real_value') should not be used with logical comparison operator '=='
  // This uses an input real port and an always @* block to avoid previous issues like SYNTH_5143 and W528.
  always @* begin
    if (my_real_value == 100.0) begin
      // Empty block to ensure no other rules (e.g., W528 for unused signals, or latches) are triggered.
    end
  end

endmodule
