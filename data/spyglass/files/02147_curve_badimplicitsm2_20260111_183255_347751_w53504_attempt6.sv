module curve_badimplicitsm2_20260111_183255_347751_w53504_attempt6 (
  input wire clk,
  input wire in_data,
  output reg q_pos,
  output reg q_neg
);

  // This always block contains implicit sequential logic with states updated on different clock phases.
  always begin
    @(posedge clk) q_pos <= in_data; // q_pos updated on positive edge
    @(negedge clk) q_neg <= ~in_data; // q_neg updated on negative edge, triggering the violation
  end

endmodule
