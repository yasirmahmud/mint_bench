module curve_w352_20260111_031016_attempt11 (
  output reg [7:0] dummy_out
);

  integer i;

  always @* begin
    // Assign a default value to 'dummy_out' to prevent latches and ensure it's always driven.
    dummy_out = 8'd0;

    // The 'for' loop condition `(i == i)` is a tautology; it is always true regardless of 'i'.
    // This causes the loop to execute indefinitely (never terminate), triggering SpyGlass W352.
    // The loop variable 'i' is explicitly used in the condition `(i == i)`, thereby avoiding W481a
    // ("The step variable of the 'for' loop is not used in the loop condition").
    // The 'for' loop is placed within an `always @*` block (instead of an `initial` block)
    // to avoid potential `SYNTH_5143` warnings ("Synthesizable 'initial' statements should not contain a 'for' statement").
    // The loop body is kept empty to ensure minimality and prevent introduction of other design issues.
    for (i = 0; (i == i); i = i + 1) begin
      // Empty loop body.
    end
    // Code following an infinite loop in an `always` block is considered unreachable by some tools.
    // However, for linting purposes targeting W352 specifically, this should not trigger other
    // unrelated violations in SpyGlass, which often focuses on structural/synthesizability issues.
  end

endmodule
