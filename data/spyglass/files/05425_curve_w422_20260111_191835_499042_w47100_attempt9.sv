module curve_w422_20260111_191835_499042_w47100_attempt9 (
  input clk_main,
  input clk_aux,
  output reg status_reg
);

  // W422 violation: The event control list for this always block contains more than one clock.
  // Specifically, it is sensitive to both 'posedge clk_main' and 'posedge clk_aux'.
  // Synthesis tools typically do not support a single sequential block triggered by multiple independent clock edges,
  // leading to potential un-synthesizability and unpredictable behavior.
  always @(posedge clk_main or posedge clk_aux) begin
    status_reg <= 1'b1; // Simple assignment to prevent latches and keep logic minimal
  end

endmodule
