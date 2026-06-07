module curve_synth_5321_20260110_182955_attempt8 (
  input clk,
  input d_in,
  output reg q_out
);

  // SYNTH_5321 violation: Clocked if-else construct is not synthesizable to standard logic.
  // This rule is triggered because the clock signal 'clk' is referenced (i.e., checked with 'if (clk == 1'b1)')
  // inside an always block that is sensitive to the positive edge of 'clk' itself.
  // Such a construct indicates an attempt to use the clock signal as a data signal within the clock domain
  // of the flip-flop, which is not supported by standard synthesis tools.
  always @(posedge clk) begin
    if (clk == 1'b1) begin
      q_out <= d_in;
    end else begin
      q_out <= 1'b0;
    end
  end

endmodule
