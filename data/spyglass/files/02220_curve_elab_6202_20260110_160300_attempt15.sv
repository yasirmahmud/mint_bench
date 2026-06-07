module curve_elab_6202_20260110_160300_attempt15 ();

  genvar i;

  // ELAB_6202: Infinite for loop found in the design
  // This generate for loop is designed to be mathematically infinite during elaboration.
  // The genvar 'i' starts at 0 and increments by 2 in each iteration.
  // The condition 'i != 1' will always be true because 'i' will always be an even number (0, 2, 4, ...)
  // and thus will never be equal to 1. This holds true even with potential integer overflow/wrap-around
  // as 1 is an odd number.
  // This construct avoids 'initial' block warnings (SYNTH_5143), constant condition warnings (W352),
  // and ensures the step variable is used in the condition (W481a) and is of integer type (W480).
  generate for (i = 0; i != 1; i = i + 2) begin : infinite_gen_loop
    // An empty generate block is used to ensure minimality and focus solely on the loop condition.
  end
  endgenerate

endmodule
