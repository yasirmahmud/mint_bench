module curve_synth_5321_20260110_182955_attempt6 (
  input clk,
  input data_in,
  output reg out_reg
);

  always @(posedge clk) begin
    // SYNTH_5321 violation: A clocked if-else construct referencing the clock signal (clk) is not synthesizable to standard logic.
    // The always @(posedge clk) implies clk is high, making the if (clk == 1'b1) redundant and potentially problematic.
    if (clk == 1'b1) begin
      out_reg <= data_in;
    end else begin
      out_reg <= 1'b0;
    end
  end

endmodule
