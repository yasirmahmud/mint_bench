module curve_w352_20260111_222723_650574_w32456_attempt17 (
  output reg dummy_out
);

  integer i; // Declared for Verilog-2001 style

  initial begin
    // W352: The 'for' condition is constant - the loop will either never execute or never terminate.
    // The condition (i < 10) && 1'b0 always evaluates to 1'b0 (false), regardless of 'i',
    // causing the loop to never execute.
    // This example uses 'i' in the condition (i < 10) to specifically avoid the W481a
    // warning related to 'step variable not used in condition', which was seen in previous attempts.
    for (i = 0; (i < 10) && 1'b0; i = i + 1) begin
      // The loop body is unreachable. It is kept empty to avoid warnings from dead code.
    end

    // To prevent W481a for 'i' being completely unused (as the loop never executes),
    // and to prevent W481a for 'dummy_out' being an unused output, both are used here.
    // 'i' will retain its initial value of 0 since the loop never executed.
    // The expression (i == 0) results in a 1-bit boolean value, avoiding width mismatches
    // when assigned to the 1-bit 'dummy_out' register.
    dummy_out = (i == 0); // This will set dummy_out to 1'b1.
  end

endmodule
