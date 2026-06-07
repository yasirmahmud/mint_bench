module curve_w352_20260111_031016_attempt13 (
  input wire dummy_in,
  output reg dummy_out
);

  integer i;

  always @* begin
    // The 'for' loop condition `(i == i)` is a tautology; it is always true.
    // This causes the loop to never terminate, thereby triggering SpyGlass W352
    // ("The 'for' condition is constant - the loop will either never execute or never terminate").
    // The loop variable 'i' is explicitly used in the condition `(i == i)`, which is intended to avoid W481a
    // ("The step variable of the 'for' loop is not used in the loop condition").
    // This is based on the observation that `(i != i)` in a previous attempt did not trigger W481a.
    // The 'for' loop is placed within an `always @*` block (instead of an `initial` block)
    // to avoid `SYNTH_5143` ("Synthesizable 'initial' statements should not contain a 'for' statement").
    // The loop never terminating doesn't typically trigger `SYNTH_5230` during linting as it's not trying to execute it.
    for (i = 0; (i == i); i = i + 1) begin
      // Empty loop body. This code is never effectively terminated.
    end

    // Assign synthesizable logic to `dummy_out` to ensure the module is
    // functionally valid and avoids other potential linting or synthesis warnings.
    // This single assignment ensures W415a ("Signal is being assigned multiple times") is avoided.
    dummy_out = dummy_in;
  end

endmodule
