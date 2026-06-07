module curve_synth_5321_20260110_182955_attempt11 (
  input clk,
  output reg out_reg
);

  // SYNTH_5321 violation: Clocked if-else construct is not synthesizable to standard logic.
  // This rule is triggered because the clock signal 'clk' is used as a data condition
  // within an always block that is sensitive to its own positive edge.
  // Specifically, 'if (clk)' checks the value of the clock signal itself synchronously
  // with its rising edge, which is not a standard synthesizable construct for a flip-flop.
  always @(posedge clk) begin
    if (clk) begin // Using 'clk' directly as a boolean condition (equivalent to clk == 1'b1)
      out_reg <= 1'b1;
    end else begin
      out_reg <= 1'b0;
    end
  end

endmodule
