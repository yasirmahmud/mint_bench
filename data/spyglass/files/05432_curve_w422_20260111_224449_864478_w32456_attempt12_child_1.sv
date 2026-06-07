module curve_w422_20260111_224449_864478_w32456_attempt12 (
    input wire clk_fast,
    input wire clk_slow,
    output wire state_toggle_q
);

  // To resolve W422 and STARC05-2.3.3.1 (multi-clock in one always block),
  // the single 'always' block is split into two separate blocks, each sensitive
  // to only one clock. This ensures synthesizability.

  // The output 'state_toggle_q' is now a combinational output derived from
  // two internal registers, each toggling on its respective clock.
  // This resolves W442a as the blocks are now purely synchronous without implicit asynchronous resets.

  // Internal register for clk_fast domain
  reg state_toggle_q_fast_r;

  // Internal register for clk_slow domain
  reg state_toggle_q_slow_r;

  // Initialize internal registers to a known state (optional but good practice)
  initial begin
    state_toggle_q_fast_r = 1'b0;
    state_toggle_q_slow_r = 1'b0;
  end

  // Toggle logic for clk_fast
  always @(posedge clk_fast) begin
    state_toggle_q_fast_r <= ~state_toggle_q_fast_r; 
  end

  // Toggle logic for clk_slow
  always @(posedge clk_slow) begin
    state_toggle_q_slow_r <= ~state_toggle_q_slow_r;
  end

  // Combine the outputs of the two togglers using XOR logic.
  // This preserves the functional behavior that 'state_toggle_q' changes
  // whenever a positive edge on either clk_fast or clk_slow occurs.
  // Note on simultaneous edges: If both clk_fast and clk_slow rise at the exact same time,
  // both internal registers will toggle. The XOR operation will then effectively
  // result in 'state_toggle_q' toggling twice, returning to its original state.
  // This differs from the original single 'always' block's behavior, which would
  // toggle once in simulation if both clocks rise simultaneously. However, for
  // truly asynchronous clocks, simultaneous edges are typically considered a
  // problematic scenario, and this split-register approach is a standard synthesizable
  // approximation for independent toggle events.
  assign state_toggle_q = state_toggle_q_fast_r ^ state_toggle_q_slow_r;

endmodule
