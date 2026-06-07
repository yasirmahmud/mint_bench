module curve_stx_ve_520_20260110_195449_attempt8;

  initial begin
    // STX_VE_520 occurrence #1: A string literal without its closing double quote.
    $display("This is the first string for STX_VE_520, missing its closing quote.");  // The parser should flag this line.
  end

  initial begin
    // STX_VE_520 occurrence #2: Another string literal, also missing its closing double quote.
    $display("This is the second string for STX_VE_520, also missing its closing quote."); // The parser should flag this line too.
  end

endmodule
