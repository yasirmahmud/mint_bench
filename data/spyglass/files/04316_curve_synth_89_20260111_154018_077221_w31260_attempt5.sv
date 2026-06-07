module curve_synth_89_20260111_154018_077221_w31260_attempt5 (
  input clk,
  output [3:0] counter_out
);

  // SYNTH_89 violation: Initial Assignment at Declaration for (my_counter) is ignored by synthesis.
  // Synthesis tools typically ignore initial assignments at declaration for registers
  // that are subsequently driven by sequential logic (e.g., an always @(posedge clk) block).
  // The initial value 4'hA will not be synthesized as a power-on reset value.
  reg [3:0] my_counter = 4'hA;

  always @(posedge clk) begin
    my_counter <= my_counter + 1;
  end

  // Connect the internal counter to the output to avoid an unused signal warning.
  assign counter_out = my_counter;

endmodule
