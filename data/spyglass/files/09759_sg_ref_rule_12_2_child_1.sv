module self_loop_ex2(input in_a, output reg out_b);
  // The original 'and (out_b, in_a, out_b);' implements a latch behavior where
  // out_b is cleared when in_a is low, and holds its value when in_a is high.
  // This behavior is preserved by inferring a latch using an always @* block.
  always @* begin
    if (!in_a) begin
      out_b = 1'b0;
    end
    // When in_a is high, 'out_b' retains its previous value, inferring a latch.
  end
endmodule
