module curve_mixedsenselist_20260111_192248_701928_w37940_attempt8 (
  input clk,
  input reset_n, // Active-low reset, used as a level-sensitive signal
  input data_in,
  output reg data_out
);

  // This always block triggers a 'mixedsenselist' violation.
  // The sensitivity list contains both an edge-sensitive condition ('negedge clk')
  // and a level-sensitive condition ('reset_n'). This mix is considered
  // non-synthesizable or ambiguous by many synthesis tools, leading to the violation.
  always @(negedge clk or reset_n) begin
    if (!reset_n) begin // Asynchronous active-low reset logic
      data_out <= 1'b0;
    end else begin
      data_out <= data_in; // Data capture on the negative edge of clk
    end
  end

endmodule
