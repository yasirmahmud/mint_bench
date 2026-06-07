module curve_synth_5321_20260112_001218_050690_w47152_attempt17 (
  input wire clock_in,
  input wire data_in,
  output reg q_out
);

  // SYNTH_5321 violation: Clocked if-else construct is not synthesizable to standard logic.
  // This rule triggers when the clock signal itself ('clock_in') is used as a data condition
  // within an always block sensitive to its own edge (@(posedge clock_in)).
  // Even though 'if (clock_in == 1'b0)' is logically false at 'posedge clock_in', the attempt
  // to evaluate the clock signal synchronously is flagged as unsynthesizable by SpyGlass.
  always @(posedge clock_in) begin
    if (clock_in == 1'b0) begin // Referencing the clock signal 'clock_in' in a conditional statement
      q_out <= 1'b0;
    end else begin
      q_out <= data_in;
    end
  end

endmodule
