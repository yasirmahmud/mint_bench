module curve_synth_5368_20260111_215330_271713_w15680_attempt11 (
  input wire data_in,
  input wire set_async,
  output reg q_out
);

  // The original design uses 'q_out' as a clock edge in its sensitivity list
  // ('negedge q_out') and also assigns to 'q_out' asynchronously within an
  // 'if (set_async)' block. This creates a SYNTH_5368 violation, as a signal
  // cannot be both an asynchronous clock and asynchronously driven within the
  // same always block, leading to an unsynthesizable feedback race condition.

  // To preserve the functional behavior as closely as possible while resolving
  // the violation, we must interpret the self-clocking 'negedge q_out' behavior.
  // Analysis of the original logic:
  // 1. If 'set_async' is high, 'q_out' is asynchronously forced to 0.
  // 2. Otherwise (if 'set_async' is low), 'q_out' updates to 'data_in' on its
  //    own negative edge.
  // This implies:
  //    - If 'q_out' is currently 1 and 'data_in' becomes 0, 'q_out' transitions
  //      1 -> 0. This 'negedge q_out' then triggers the update, causing 'q_out' to become 0.
  //    - If 'q_out' is currently 0 and 'data_in' becomes 1, no 'negedge q_out'
  //      event occurs. Therefore, 'q_out' remains 0.
  // This behavior means 'q_out' can only transition from 1 to 0. Once 'q_out'
  // becomes 0 (either by 'set_async' or by 'data_in' being 0 while 'q_out' was 1),
  // it will remain 0, as there's no mechanism to bring it back to 1 via 'data_in'.
  // The 'data_in' essentially acts as an enable for 'q_out' to *stay* 1.

  // The corrected logic implements this derived behavior as a synthesizable latch:
  // q_out is 0 if set_async is high (asynchronous reset).
  // Otherwise, q_out becomes 0 if data_in is 0.
  // Otherwise (if data_in is 1), q_out maintains its previous state (which would
  // have to be 1 for it to not have already transitioned to 0).
  // This is equivalent to: q_out = !set_async && data_in && q_out (if it was 1).
  // Or more simply: q_out = set_async ? 1'b0 : (data_in & q_out);

  always @(set_async or data_in or q_out) begin // 'q_out' is now a data input for a latch, not a clock
    if (set_async) begin // Asynchronous set condition preserved
      q_out = 1'b0;
    end else begin
      // Synchronous data path relative to 'q_out's negedge (interpreted as latch behavior)
      // If data_in is 0, q_out becomes 0.
      // If data_in is 1, q_out retains its state.
      q_out = data_in & q_out;
    end
  end

endmodule
