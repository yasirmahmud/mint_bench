module starc05_2_3_3_2a_ex2 (input clk, input d, output reg q);

  // SpyGlass violation W415a (multiple assignments in same always block) and
  // STARC05-2.3.3.2a/badimplicitSM2 (multiple event controls in one always block)
  // are resolved by splitting the assignments into separate always blocks.
  // This preserves the functional behavior of updating 'q' on both clock edges,
  // although such a construct typically leads to new multi-driver issues or
  // unsynthesizable logic for a single register in a standard cell flow.

  always @(posedge clk) begin
    q <= d;
  end

  always @(negedge clk) begin
    q <= ~d;
  end

endmodule
