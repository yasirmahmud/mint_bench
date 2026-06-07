module curve_w352_20260111_031016_attempt15 (
  input wire dummy_in,
  output reg dummy_out
);

  integer i;

  always @* begin
    // W352: The 'for' condition is constant - the loop will either never execute or never terminate.
    // The condition (i*2 >= i) is always true for non-negative 'i' (which it always is in this loop).
    // This creates an infinite loop, triggering W352 because the loop never terminates.
    //
    // The loop variable 'i' is used in the condition, preventing W481a.
    // The 'for' loop is within an 'always @*' block, preventing SYNTH_5143.
    // The expression (i*2 >= i) is non-trivial enough to ideally avoid being optimized away
    // or treated as a simple constant '1' which might implicitly trigger W481a.
    for (i = 0; (i*2 >= i); i = i + 1) begin
      // Empty loop body. This code represents a non-terminating simulation construct.
      // It won't synthesize but SpyGlass should report W352 during linting.
    end

    // Minimal synthesizable logic to ensure the module is valid and avoids other common warnings.
    dummy_out = dummy_in;
  end

endmodule
