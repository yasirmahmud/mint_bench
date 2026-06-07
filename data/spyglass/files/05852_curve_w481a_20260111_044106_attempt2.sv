module curve_w481a_20260111_044106_attempt2;

  integer i;
  reg loop_active;

  initial begin
    loop_active = 1'b1; // Initialize the loop condition variable to true

    // W481a: The step variable 'i' is not used directly in the loop condition 'loop_active'.
    // The condition 'loop_active' is a simple boolean variable, not an expression involving 'i'.
    // The loop is made bounded by updating 'loop_active' inside the loop body, 
    // thus preventing an unbounded loop violation (SYNTH_5143).
    for (i = 0; loop_active; i = i + 1) begin
      $display("Iteration %0d: loop_active = %b", i, loop_active);
      
      // Terminate the loop after 3 iterations (for i=0, 1, 2).
      // This ensures the loop is bounded, but the direct condition 'loop_active'
      // in the 'for' statement still does not depend on 'i'.
      if (i >= 2) begin
        loop_active = 1'b0; // Set condition to false to exit the loop
      end
    end
    $display("Loop finished. Final i = %0d", i);
  end

endmodule
