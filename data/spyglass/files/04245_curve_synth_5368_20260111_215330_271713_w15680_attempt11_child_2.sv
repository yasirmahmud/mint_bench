module curve_synth_5368_20260111_215330_271713_w15680_attempt11 (
  input wire data_in,
  input wire set_async,
  output reg q_out
);

  // The original design had a SYNTH_5368 violation due to 'q_out' being used as a clock
  // and also asynchronously driven. The previous attempt correctly interpreted this as
  // a latch behavior, but the specific assignment 'q_out = data_in & q_out;' within
  // a combinational always block caused a 'CombLoop' violation (ID 8) because 'q_out'
  // was on both the left and right hand sides of an assignment, and also in the sensitivity list,
  // leading to an explicit combinational feedback path that lint tools flag as a loop.

  // To resolve the 'CombLoop' violation while preserving the latch's functional behavior:
  // 1. Removed 'q_out' from the sensitivity list. For a latch, the sensitivity list
  //    should include all inputs that can change the latch's state (e.g., enable, data,
  //    asynchronous controls). The latch's output itself is implicitly held when not driven.
  // 2. Modified the 'else' branch to leverage implicit latch inference. Instead of
  //    explicitly assigning 'q_out = q_out' or 'q_out = data_in & q_out;', we leave 'q_out'
  //    unassigned in the branches where it should hold its previous value. This is the
  //    standard and synthesizable way to infer a latch in Verilog.

  // The derived functional behavior of the latch is:
  // - 'q_out' is 0 if 'set_async' is high (asynchronous reset).
  // - Otherwise (if 'set_async' is low):
  //    - 'q_out' becomes 0 if 'data_in' is 0 (synchronous clear/reset).
  //    - 'q_out' maintains its previous state if 'data_in' is 1 (synchronous hold).

  always @(set_async or data_in) begin // Removed 'q_out' from sensitivity list for correct latch inference
    if (set_async) begin // Asynchronous clear (highest priority)
      q_out = 1'b0;
    end else if (!data_in) begin // Synchronous clear condition if data_in is 0
      q_out = 1'b0;
    end
    // else { // This is the condition: set_async is 0 AND data_in is 1
    //   // q_out is not explicitly assigned here. This implicit non-assignment
    //   // causes synthesis tools to infer a latch, where q_out holds its previous
    //   // value under these conditions.
    // }
  end

endmodule
