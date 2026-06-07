module curve_w422_20260111_224449_864478_w32456_attempt12 (
    input wire clk_fast,
    input wire clk_slow,
    output reg state_toggle_q
);

  // W422 violation: Block might be un-synthesizable by some tool: event control has more than one clock.
  // This 'always' block is triggered by two independent positive clock edges (clk_fast and clk_slow).
  // Synthesis tools typically do not support a single sequential block triggered by multiple independent clock edges.
  always @(posedge clk_fast or posedge clk_slow) begin
    state_toggle_q <= ~state_toggle_q; // Toggles a register to ensure it's used and modified, and infers a flip-flop.
  end

endmodule
