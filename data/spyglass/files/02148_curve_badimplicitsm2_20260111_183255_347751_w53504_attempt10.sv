module curve_badimplicitsm2_20260111_183255_347751_w53504_attempt10 (
  input wire clk,
  input wire data_in,
  output reg state_p_reg,
  output reg state_n_reg
);

  // This 'always' block triggers the badimplicitSM2 violation because it attempts to update
  // sequential logic elements (state_p_reg and state_n_reg) on both positive and negative
  // clock edges within the same procedural block, which is considered unsynthesizable by SpyGlass.
  // This violates the rule "states can only be updated on same clock phase".
  always begin
    @(posedge clk) begin
      state_p_reg <= data_in;
    end
    @(negedge clk) begin // This line, in conjunction with the posedge above, triggers the violation.
      state_n_reg <= ~data_in;
    end
  end

endmodule
