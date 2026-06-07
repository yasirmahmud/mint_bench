module my_clock_gate_cell (input CLK, input EN, output GCLK);
  reg en_latch_q;

  // Behavioral model for a glitch-free clock gate latch
  // The latch is transparent when CLK is low and holds its value when CLK is high.
  always @(EN or CLK) begin
    if (!CLK) begin // Latch is enabled when CLK is low
      en_latch_q = EN;
    end
  end

  // Gated clock output: CLK is passed only when the latched enable is high.
  assign GCLK = CLK & en_latch_q;
endmodule
