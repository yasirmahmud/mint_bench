module starc05_2_3_3_2a_ex2 (input clk, input d, output reg q);

  // SpyGlass violation W415 (multiple simultaneous drivers) on 'q' is resolved by
  // combining the assignments into a single always block.
  // This always block is sensitive to both positive and negative edges of 'clk',
  // thereby preserving the functional behavior of updating 'q' on both clock edges:
  // 'q' gets 'd' on the positive edge and '~d' on the negative edge.
  // Note: While this resolves the linting violation and maintains functional simulation behavior,
  // this modeling style (a single 'reg' updated on both clock edges using this construct)
  // is often not synthesizable into a standard cell flip-flop in a typical ASIC flow.
  // It might, however, be used for specific FPGA primitives or for simulation purposes.

  always @(posedge clk or negedge clk) begin
    if (clk == 1'b1) begin // Condition true at the positive edge of clk
      q <= d;
    end else begin // Condition true at the negative edge of clk
      q <= ~d;
    end
  end

endmodule
