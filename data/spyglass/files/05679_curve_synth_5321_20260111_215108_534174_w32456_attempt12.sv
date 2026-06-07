module synth_5321_example_6 (
  input clk,
  input rst_n,
  input data_in,
  output reg data_out
);

  // SYNTH_5321 violation: Clocked if-else construct is not synthesizable to standard logic.
  // This rule is triggered when the clock signal itself is used as a condition
  // within an always block sensitive to that same clock's edge. Here, `if (clk == 1'b0)`
  // is checked inside `always @(posedge clk)`. On a positive edge, `clk` is conceptually `1'b1`,
  // so checking for `1'b0` within this context is non-standard and non-synthesizable
  // as a standard flip-flop control.
  always @(posedge clk) begin
    if (!rst_n) begin
      data_out <= 1'b0;
    end else begin
      if (clk == 1'b0) begin // Violation: Using 'clk' as a data condition within its own posedge-triggered block
        data_out <= data_in;
      end else begin
        data_out <= ~data_in;
      end
    end
  end

endmodule
