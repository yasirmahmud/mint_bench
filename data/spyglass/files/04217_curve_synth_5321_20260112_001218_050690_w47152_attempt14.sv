module curve_synth_5321_20260112_001218_050690_w47152_attempt14 (
  input wire clk,
  input wire data_in,
  output reg data_out
);

  // SYNTH_5321 violation: Clocked if-else construct is not synthesizable to standard logic.
  // This rule is triggered when the clock signal itself is used as a data condition
  // within an always block that is clocked by that very signal (e.g., @(posedge clk) and then if (clk)).
  always @(posedge clk) begin
    // Using 'clk' directly as a boolean condition (equivalent to clk == 1'b1)
    // within its own clocked domain is an unsynthesizable construct.
    if (clk) begin 
      data_out <= data_in;
    end else begin
      // While the 'else' path is technically unreachable at posedge clk,
      // its presence ensures complete assignment to avoid unintended latch inference,
      // focusing the violation solely on the invalid use of 'clk' as a condition.
      data_out <= 1'b0;
    end
  end

endmodule
