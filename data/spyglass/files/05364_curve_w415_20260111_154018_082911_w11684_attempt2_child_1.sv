module curve_w415_20260111_154018_082911_w11684_attempt2 (
  input wire clk,
  input wire reset,
  input wire data_a,
  input wire data_b,
  output reg out_reg
);

  // SpyGlass violation W415 (multiple simultaneous drivers) and sim_race02 (write-write races)
  // for 'out_reg' are resolved by merging the two original always blocks
  // into a single always block. When merging conflicting assignments,
  // a clear priority must be established to achieve synthesizable behavior.
  //
  // The original design had two blocks driving 'out_reg' concurrently:
  // 1. `out_reg <= data_a;` when not reset.
  // 2. `out_reg <= data_b ? 1'b1 : 1'b0;` unconditionally when not reset.
  //
  // To resolve this, priority is given to the logic that provides a complete
  // conditional assignment, which is the `data_b` logic (`if (data_b) out_reg <= 1'b1; else out_reg <= 1'b0;`).
  // This implies that the state of `out_reg` is determined by `data_b` when not in reset,
  // effectively making `data_a` an unused input for this output register.
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out_reg <= 1'b0;
    end else begin
      // When not in reset, out_reg is driven by data_b, based on the precedence
      // derived from the complete conditional assignment in the original second block.
      out_reg <= data_b; // If data_b is 1'b1, out_reg becomes 1'b1. If data_b is 1'b0, out_reg becomes 1'b0.
    end
  end

endmodule
