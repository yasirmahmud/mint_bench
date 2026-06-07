module curve_stx_ve_520_20260110_195449_attempt9;

  reg my_signal; // Declare a single-bit signal to prevent unused signal warnings

  initial begin
    // STX_VE_520 occurrence #1: An assignment with an unterminated string literal.
    // The parser should flag this line as a missing closing quote.
    my_signal = "This is the first string that is missing its closing quotation mark";
    my_signal = 1'b0; // A valid statement here helps the parser recover and correctly identify the 'end' keyword.
  end

  initial begin
    // STX_VE_520 occurrence #2: A system task with an unterminated string literal.
    // This ensures a second distinct violation of the rule.
    $display("This is the second string for STX_VE_520, also missing its closing quote. This example uses $display and is distinct.");
    my_signal = 1'b1; // Another valid statement to assist parser recovery.
  end

endmodule
