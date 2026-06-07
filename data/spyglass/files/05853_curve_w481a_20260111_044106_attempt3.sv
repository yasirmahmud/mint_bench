module curve_w481a_20260111_044106_attempt3 (
  input clk,
  input rst_n,
  input start_pulse,
  output reg [7:0] result_val
);

  integer i; // The loop step variable
  reg loop_active_condition; // Condition for the 'for' loop
  reg [7:0] iteration_count_internal; // Used to bound the loop and make assignments visible
  
  // Sequential block for synthesizable logic
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      loop_active_condition <= 1'b0;
      iteration_count_internal <= 8'd0;
      result_val <= 8'd0;
      i = 0; // Reset 'i' for consistency, though its scope is within the loop
    end else begin
      // On a 'start_pulse', activate the loop condition and reset internal counters.
      // This pulse triggers the problematic loop behavior for one clock cycle.
      if (start_pulse) begin
        loop_active_condition <= 1'b1;
        iteration_count_internal <= 8'd0; // Reset for a fresh loop run
        i = 0; // Start 'i' from 0 for the loop
      end else if (!loop_active_condition) begin
        // If not actively looping and no start pulse, ensure values are stable.
        // This 'else if' is important to allow the loop to run when 'start_pulse' is high.
        iteration_count_internal <= iteration_count_internal; // Hold previous value
        result_val <= result_val; // Hold previous value
      end

      // W481a: The step variable 'i' is not used in the loop condition 'loop_active_condition'.
      // This 'for' loop within a sequential 'always @(posedge clk)' block is problematic
      // for synthesis. In simulation, if 'loop_active_condition' is true, 'i' increments
      // multiple times instantaneously within a single clock cycle. This is not how
      // synthesizable 'for' loops work (they are typically unrolled or imply a state machine
      // where 'i' increments across clock cycles).
      // This structure is often flagged as an 'unsynthesizable loop' due to the immediate,
      // non-clocked updates of 'i' and the loop-bound controlled by an internal register
      // that is also updated instantaneously within the loop.
      for (i = 0; loop_active_condition; i = i + 1) begin // <-- Target: W481a violation
        iteration_count_internal <= iteration_count_internal + 1; // Increment a separate counter
        result_val <= iteration_count_internal; // Assign some intermediate result

        // This internal condition controls the termination of the instantaneous loop.
        // It uses 'iteration_count_internal' (which is also updated instantly), not 'i',
        // to modify 'loop_active_condition'. This makes the loop bounded but still problematic.
        if (iteration_count_internal >= 8'd5) begin
          loop_active_condition <= 1'b0; // Terminate the loop for the current clock cycle
        end
      end
    end
  end

endmodule
