module curve_synth_5321_20260110_182955_attempt10 (
  input clk,
  input data_in,
  output reg out_reg
);

  // SYNTH_5321 violation: Clocked if-else construct is not synthesizable to standard logic.
  // This rule is triggered because the clock signal 'clk' is referenced (i.e., checked with 'if (clk == 1'b0')
  // inside an always block that is sensitive to the positive edge of 'clk' itself.
  // This construct attempts to use the clock signal as a data condition within its own clock domain,
  // which is not a standard synthesizable construct for a flip-flop.
  always @(posedge clk) begin
    if (clk == 1'b0) begin
      out_reg <= data_in;
    end else begin
      out_reg <= !data_in;
    end
  end

endmodule
