module curve_w481a_20260111_044106_attempt2;

  integer i;

  initial begin
    // Original issue W481a: The step variable 'i' was not used directly in the loop condition 'loop_active'.
    // Fix: The loop condition now directly uses 'i' (i <= 2).
    // This change also makes the 'loop_active' variable redundant.
    // Original issue W528: Variable 'loop_active' set but not read.
    // Fix: The 'loop_active' variable has been removed as it's no longer needed, resolving W528.
    // The loop now explicitly runs for i = 0, 1, 2, which matches the original functional behavior.
    for (i = 0; i <= 2; i = i + 1) begin
      // The original design displayed 'loop_active' as '1'b1' for i=0, 1, 2 (before its potential update).
      // This display behavior is preserved by showing a constant '1'b1' for the implied active state.
      $display("Iteration %0d: loop_active = %b", i, 1'b1);
    end
    $display("Loop finished. Final i = %0d", i);
  end

endmodule
