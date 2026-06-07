module curve_w352_20260111_031016_attempt12 (
  input wire dummy_in,
  output reg dummy_out
);

  integer i;

  always @* begin
    // Default assignment to avoid potential latches for dummy_out if not always driven.
    dummy_out = 1'b0;

    // The 'for' loop condition `(i != i)` is a tautology; it is always false regardless of 'i'.
    // This causes the loop to never execute, thereby triggering SpyGlass W352
    // ("The 'for' condition is constant - the loop will either never execute or never terminate").
    // The loop variable 'i' is explicitly used in the condition `(i != i)`, thereby avoiding W481a
    // ("The step variable of the 'for' loop is not used in the loop condition").
    // The 'for' loop is placed within an `always @*` block (instead of an `initial` block)
    // to avoid `SYNTH_5143` ("Synthesizable 'initial' statements should not contain a 'for' statement").
    // Since the loop never executes (0 iterations), it avoids `SYNTH_5230` warnings
    // ("Number of iterations in for-loop exceeds max. allowable limit"), which was triggered in the previous attempt.
    for (i = 0; (i != i); i = i + 1) begin
      // Empty loop body. This code is never reached.
    end

    // Assign synthesizable logic to `dummy_out` to ensure the module is
    // functionally valid and avoids other potential linting or synthesis warnings
    // related to unsynthesized design units or dangling outputs.
    dummy_out = dummy_in;
  end

endmodule
