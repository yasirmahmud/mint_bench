module curve_w481a_20260111_185503_557821_w37940_attempt8 ();

  integer loop_iterator;

  initial begin
    $display("Starting loop for W481a violation...");

    // The loop condition now directly uses 'loop_iterator', resolving W481a.
    // The loop runs from loop_iterator = 0 up to 7, inclusive, as per original functional behavior.
    for (loop_iterator = 0; loop_iterator <= 7; loop_iterator = loop_iterator + 1) begin
      // Use loop_iterator to prevent W528 (unused signal) and show progress.
      $display("Inside loop: loop_iterator = %d", loop_iterator);
    end
    $display("Loop finished.");
  end

endmodule
