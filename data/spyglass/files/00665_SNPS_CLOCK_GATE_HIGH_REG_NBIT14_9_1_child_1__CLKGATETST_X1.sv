module CLKGATETST_X1 (
	input CLK,
	input E,
	input SE,
	output GCK
);

   reg latched_en;

   // Behavioral model for a clock gating cell with a transparent latch for the enable signal.
   // The latch is transparent when CLK is low, passing the combined enable signal (E | SE).
   // When CLK is high, the latch holds its value.
   always @(CLK or E or SE) begin
      if (!CLK) begin // Latch is transparent when CLK is low
         latched_en = E | SE; // Combine functional enable 'E' with test enable 'SE'
      end
      // else (CLK is high) latched_en holds its current value (implied latch behavior)
   end

   // The gated clock is produced by ANDing the clock input with the latched enable.
   // This ensures the clock is only propagated when the enable is active.
   assign GCK = CLK & latched_en;

endmodule
