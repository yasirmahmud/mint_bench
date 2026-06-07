module synth_5321_example_6 (
  input clk,
  output reg out_data
);

  // SYNTH_5321 violation: Clocked if-else construct is not synthesizable to standard logic.
  // This rule is triggered when the clock signal itself is used as a condition
  // within an always block sensitive to that same clock's edge.
  // Specifically, 'if (!clk)' checks for the clock being low inside an always block
  // triggered by the positive edge of 'clk'. This is a non-standard and non-synthesizable
  // construct for describing synchronous logic, as 'clk' is high at the active edge.
  always @(posedge clk) begin
    if (!clk) begin // Violation: Checking '!clk' (clk == 1'b0) within 'always @(posedge clk)'
      out_data <= 1'b1;
    end else begin
      out_data <= 1'b0;
    end
  end

endmodule
