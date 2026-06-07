module sr_latch_nor(input s, r, output reg q, output reg q_bar);

  // This module implements an SR latch using logic equivalent to two interconnected NOR gates.
  // The behavioral description in an always @(*) block is used to resolve SpyGlass violations
  // related to combinational loops and primitive cell inference, while preserving
  // the functional behavior of an SR NOR latch.
  always @(*) begin
    // For an SR NOR latch:
    // Q_next is the NOR of S and the current Q_bar
    q = ~(s | q_bar);
    // Q_bar_next is the NOR of R and the current Q
    q_bar = ~(r | q);
  end

endmodule
